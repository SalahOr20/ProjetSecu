import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext';

const Cart = () => {
  const { user } = useContext(AuthContext);
  const [cart, setCart] = useState(JSON.parse(localStorage.getItem('cart')) || []);
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    const fetchProducts = async () => {
      if (cart.length === 0) {
        setLoading(false);
        return;
      }

      try {
        const productIds = cart.map(item => item.product_id);
        const productPromises = productIds.map(id => 
          axios.get(`http://localhost:8000/api/products/${id}/`)
        );
        
        const responses = await Promise.all(productPromises);
        const productsData = responses.map(res => res.data);
        setProducts(productsData);
      } catch (err) {
        setError('Erreur lors du chargement des produits. Veuillez réessayer plus tard.');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, [cart]);

  const updateQuantity = (index, newQuantity) => {
    if (newQuantity < 1) return;
    
    const updatedCart = [...cart];
    updatedCart[index].quantity = newQuantity;
    setCart(updatedCart);
    localStorage.setItem('cart', JSON.stringify(updatedCart));
  };

  const removeItem = (index) => {
    const updatedCart = cart.filter((_, i) => i !== index);
    setCart(updatedCart);
    localStorage.setItem('cart', JSON.stringify(updatedCart));
  };

  const calculateTotal = () => {
    return cart.reduce((total, item, index) => {
      const product = products.find(p => p.id === item.product_id);
      return total + (product ? product.price * item.quantity : 0);
    }, 0);
  };

  const validateOrder = async () => {
    if (!user) {
      setError('Veuillez vous connecter pour valider votre commande.');
      return;
    }

    const token = localStorage.getItem('accessToken');
    if (!token) {
      setError('Session expirée. Veuillez vous reconnecter.');
      return;
    }

    const product_ids = cart.map(item => item.product_id);
    const quantities = cart.map(item => item.quantity);

    try {
      await axios.post('http://localhost:8000/api/products/create-order/', {
        product_ids,
        quantities,
      }, {
        headers: {
          Authorization: `Bearer ${token}`,
        }
      });

      setSuccess('Commande validée avec succès !');
      localStorage.removeItem('cart');
      setCart([]);
      
      // Effacer le message de succès après 3 secondes
      setTimeout(() => {
        setSuccess('');
      }, 3000);
    } catch (err) {
      setError('Erreur lors de la validation de la commande. Veuillez réessayer.');
      console.error(err.response?.data || err.message);
    }
  };

  if (loading) {
    return (
      <div className="container">
        <div className="loading">Chargement du panier...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container">
        <div className="message message-error">{error}</div>
        <Link to="/products" className="btn btn-primary" style={{ marginTop: '1rem' }}>
          Continuer mes achats
        </Link>
      </div>
    );
  }

  if (!cart.length) {
    return (
      <div className="container">
        <div className="empty-cart">
          <h2 className="page-title">Votre panier est vide</h2>
          <p style={{ textAlign: 'center', marginBottom: '2rem' }}>
            Découvrez nos produits et commencez vos achats.
          </p>
          <div style={{ textAlign: 'center' }}>
            <Link to="/products" className="btn btn-primary">
              Voir les produits
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="container">
      <h1 className="page-title">Mon Panier</h1>
      
      {success && <div className="message message-success">{success}</div>}
      
      <div className="cart-container">
        {cart.map((item, index) => {
          const product = products.find(p => p.id === item.product_id);
          if (!product) return null;
          
          return (
            <div key={index} className="cart-item">
              <img 
                src={product.image || 'https://via.placeholder.com/100x100?text=Produit'} 
                alt={product.name}
              />
              <div className="cart-item-details">
                <h3 className="cart-item-title">{product.name}</h3>
                <p className="cart-item-price">{product.price} €</p>
                <div className="cart-item-quantity">
                  <button 
                    className="quantity-btn" 
                    onClick={() => updateQuantity(index, item.quantity - 1)}
                    disabled={item.quantity <= 1}
                  >
                    -
                  </button>
                  <span>{item.quantity}</span>
                  <button 
                    className="quantity-btn" 
                    onClick={() => updateQuantity(index, item.quantity + 1)}
                  >
                    +
                  </button>
                </div>
              </div>
              <div className="cart-item-actions">
                <button 
                  className="btn" 
                  onClick={() => removeItem(index)}
                  style={{ color: 'var(--error-color)' }}
                >
                  Supprimer
                </button>
              </div>
            </div>
          );
        })}
        
        <div className="cart-summary">
          <div className="cart-total">
            <span>Total</span>
            <span>{calculateTotal().toFixed(2)} €</span>
          </div>
          <button 
            className="btn btn-primary checkout-btn" 
            onClick={validateOrder}
          >
            Valider la commande
          </button>
        </div>
      </div>
    </div>
  );
};

export default Cart;
