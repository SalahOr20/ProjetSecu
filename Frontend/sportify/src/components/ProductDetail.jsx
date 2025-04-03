import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { useParams, useNavigate, Link } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext';

// Tableau d'images de sport
const sportImages = [
  'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=800&q=80', // Basketball
  'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?w=800&q=80', // Football
  'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=800&q=80', // Running
  'https://images.unsplash.com/photo-1517344368193-41552b6ad3f5?w=800&q=80', // Tennis
  'https://images.unsplash.com/photo-1574680178050-55c6a6a96e0a?w=800&q=80', // Volleyball
  'https://images.unsplash.com/photo-1535131749006-b7f58c99034b?w=800&q=80', // Cycling
  'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&q=80', // Fitness
  'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800&q=80', // Swimming
  'https://images.unsplash.com/photo-1515523110800-9415d13b84a8?w=800&q=80', // Boxing
  'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=800&q=80', // Yoga
  'https://images.unsplash.com/photo-1591258370814-01609b341790?w=800&q=80', // Climbing
  'https://images.unsplash.com/photo-1530549387789-4c1017266635?w=800&q=80'  // Gym equipment
];

// Fonction pour obtenir une image aléatoire
const getRandomImage = () => {
  return sportImages[Math.floor(Math.random() * sportImages.length)];
};

const ProductDetail = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const { user } = useContext(AuthContext);
  const [product, setProduct] = useState(null);
  const [quantity, setQuantity] = useState(1);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  useEffect(() => {
    const fetchProduct = async () => {
      try {
        const res = await axios.get(`http://localhost:8000/api/products/${id}/`);
        setProduct({
          ...res.data,
          image: getRandomImage()
        });
      } catch (err) {
        setError('Erreur lors du chargement du produit. Veuillez réessayer plus tard.');
        console.error('Erreur lors du chargement du produit:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchProduct();
  }, [id]);

  const addToCart = () => {
    if (!user) {
      navigate('/login', { state: { message: 'Veuillez vous connecter pour ajouter des produits au panier.' } });
      return;
    }

    try {
      let cart = JSON.parse(localStorage.getItem('cart')) || [];
      cart.push({ product_id: product.id, quantity });
      localStorage.setItem('cart', JSON.stringify(cart));
      setSuccess('Produit ajouté au panier avec succès !');
      
      // Effacer le message de succès après 3 secondes
      setTimeout(() => {
        setSuccess('');
      }, 3000);
    } catch (err) {
      setError('Erreur lors de l\'ajout au panier. Veuillez réessayer.');
    }
  };

  const handleQuantityChange = (e) => {
    const value = parseInt(e.target.value);
    if (value > 0) {
      setQuantity(value);
    }
  };

  if (loading) {
    return (
      <div className="container">
        <div className="loading">Chargement du produit...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container">
        <div className="message message-error">{error}</div>
        <Link to="/products" className="btn btn-primary" style={{ marginTop: '1rem' }}>
          Retour aux produits
        </Link>
      </div>
    );
  }

  if (!product) {
    return (
      <div className="container">
        <div className="message message-error">Produit non trouvé</div>
        <Link to="/products" className="btn btn-primary" style={{ marginTop: '1rem' }}>
          Retour aux produits
        </Link>
      </div>
    );
  }

  return (
    <div className="container">
      <Link to="/products" className="btn" style={{ marginBottom: '2rem' }}>
        ← Retour aux produits
      </Link>
      
      {success && <div className="message message-success">{success}</div>}
      
      <div className="product-detail">
        <div className="product-detail-image">
          <img src={product.image} alt={product.name} />
        </div>
        <div className="product-detail-content">
          <h1 className="product-detail-title">{product.name}</h1>
          <p className="product-detail-price">{product.price} €</p>
          <div className="product-detail-description">
            <h2>Description</h2>
            <p>{product.description}</p>
          </div>
          
          <div className="product-detail-actions">
            <div className="quantity-selector">
              <label htmlFor="quantity">Quantité:</label>
              <div className="quantity-controls">
                <button 
                  className="quantity-btn" 
                  onClick={() => quantity > 1 && setQuantity(quantity - 1)}
                  disabled={quantity <= 1}
                >
                  -
                </button>
                <input 
                  type="number" 
                  id="quantity"
                  value={quantity} 
                  min="1" 
                  onChange={handleQuantityChange}
                  className="quantity-input"
                />
                <button 
                  className="quantity-btn" 
                  onClick={() => setQuantity(quantity + 1)}
                >
                  +
                </button>
              </div>
            </div>
            
            <button 
              className="btn btn-primary" 
              onClick={addToCart}
              style={{ width: '100%', marginTop: '1rem' }}
            >
              Ajouter au panier
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ProductDetail;
