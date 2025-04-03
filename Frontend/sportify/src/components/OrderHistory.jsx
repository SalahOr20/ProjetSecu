import React, { useEffect, useState, useContext } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext';

const OrderHistory = () => {
  const { user } = useContext(AuthContext);
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [products, setProducts] = useState({});

  useEffect(() => {
    const fetchOrders = async () => {
      if (!user) {
        setError('Veuillez vous connecter pour voir vos commandes.');
        setLoading(false);
        return;
      }

      const token = localStorage.getItem('accessToken');
      if (!token) {
        setError('Session expirée. Veuillez vous reconnecter.');
        setLoading(false);
        return;
      }

      try {
        const res = await axios.get('http://localhost:8000/api/products/my-orders/', {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });
        setOrders(res.data);
        
        // Récupérer les détails des produits pour chaque commande
        const productIds = new Set();
        res.data.forEach(order => {
          order.order_items.forEach(item => {
            productIds.add(item.product);
          });
        });
        
        const productPromises = Array.from(productIds).map(id => 
          axios.get(`http://localhost:8000/api/products/${id}/`)
        );
        
        const productResponses = await Promise.all(productPromises);
        const productsData = {};
        productResponses.forEach(res => {
          productsData[res.data.id] = res.data;
        });
        
        setProducts(productsData);
      } catch (err) {
        setError('Erreur lors du chargement des commandes. Veuillez réessayer plus tard.');
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchOrders();
  }, [user]);

  const formatDate = (dateString) => {
    const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
    return new Date(dateString).toLocaleDateString('fr-FR', options);
  };

  if (loading) {
    return (
      <div className="container">
        <div className="loading">Chargement de vos commandes...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container">
        <div className="message message-error">{error}</div>
        {!user && (
          <div style={{ textAlign: 'center', marginTop: '1rem' }}>
            <Link to="/login" className="btn btn-primary">
              Se connecter
            </Link>
          </div>
        )}
      </div>
    );
  }

  if (!orders.length) {
    return (
      <div className="container">
        <h1 className="page-title">Historique des commandes</h1>
        <div className="empty-orders">
          <p style={{ textAlign: 'center', marginBottom: '2rem' }}>
            Vous n'avez pas encore passé de commande.
          </p>
          <div style={{ textAlign: 'center' }}>
            <Link to="/products" className="btn btn-primary">
              Découvrir nos produits
            </Link>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="container">
      <h1 className="page-title">Historique des commandes</h1>
      
      {orders.map(order => (
        <div key={order.id} className="order-card">
          <div className="order-header">
            <div>
              <span className="order-id">Commande #{order.id}</span>
              <span className="order-date">{formatDate(order.created_at)}</span>
            </div>
            <span className="order-status order-status-completed">Livrée</span>
          </div>
          <div className="order-items">
            {order.order_items.map(item => {
              const product = products[item.product];
              if (!product) return null;
              
              return (
                <div key={item.id} className="order-item">
                  <img 
                    src={product.image || 'https://via.placeholder.com/80x80?text=Produit'} 
                    alt={product.name}
                  />
                  <div className="order-item-details">
                    <h3 className="order-item-title">{product.name}</h3>
                    <p>Quantité: {item.quantity}</p>
                  </div>
                  <div className="order-item-price">
                    {(product.price * item.quantity).toFixed(2)} €
                  </div>
                </div>
              );
            })}
            <div className="order-total">
              <span>Total</span>
              <span>{order.total_price} €</span>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};

export default OrderHistory;
