import React, { useEffect, useState } from 'react';
import { useParams, Link } from 'react-router-dom';
import axios from 'axios';

const OrderDetail = () => {
  const { orderId } = useParams();
  const [order, setOrder] = useState(null);
  const [products, setProducts] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchOrderDetail = async () => {
      const token = localStorage.getItem('accessToken');
      if (!token) {
        setError('Session expirée. Veuillez vous reconnecter.');
        setLoading(false);
        return;
      }

      try {
        // Appel sécurisé pour récupérer la commande
        const orderRes = await axios.get(`http://localhost:8000/api/products/my-orders/${orderId}/`, {
          headers: {
            Authorization: `Bearer ${token}`,
          }
        });

        const orderData = orderRes.data;
        setOrder(orderData);

        // Récupérer les détails des produits inclus dans la commande
        const productIds = [...new Set(orderData.order_items.map(item => item.product))];
        const productPromises = productIds.map(id =>
          axios.get(`http://localhost:8000/api/products/${id}/`)
        );

        const productResponses = await Promise.all(productPromises);
        const productsData = {};
        productResponses.forEach(res => {
          productsData[res.data.id] = res.data;
        });

        setProducts(productsData);
      } catch (err) {
        console.error(err);
        setError(err.response?.data?.error || "Impossible de charger la commande.");
      } finally {
        setLoading(false);
      }
    };

    fetchOrderDetail();
  }, [orderId]);

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleString('fr-FR', {
      dateStyle: 'medium',
      timeStyle: 'short'
    });
  };

  const formatPrice = (price) => {
    return typeof price === 'number'
      ? price.toFixed(2)
      : typeof price === 'string' && !isNaN(parseFloat(price))
        ? parseFloat(price).toFixed(2)
        : 'N/A';
  };

  if (loading) {
    return <div className="container"><p>Chargement...</p></div>;
  }

  if (error) {
    return (
      <div className="container">
        <p className="text-red-600">{error}</p>
        <Link to="/orders" className="btn btn-primary mt-4">← Retour à mes commandes</Link>
      </div>
    );
  }

  return (
    <div className="container">
      <h1>Détail de la commande #{order.id}</h1>
      <p>Date de commande : {formatDate(order.created_at)}</p>
      
      <div className="order-items mt-4">
        {order.order_items.map((item, index) => {
          const product = products[item.product];
          const unitPrice = product?.price;
          const subtotal = (typeof unitPrice === 'number' || !isNaN(parseFloat(unitPrice)))
            ? parseFloat(unitPrice) * item.quantity
            : null;

          return (
            <div key={index} className="order-item-detail" style={{ display: 'flex', marginBottom: '1rem' }}>
              <img 
                src={product?.image || 'https://via.placeholder.com/80x80?text=Produit'}
                alt={product?.name}
                width={80}
                height={80}
              />
              <div style={{ marginLeft: '1rem' }}>
                <h3>{product?.name || 'Produit inconnu'}</h3>
                <p>Quantité : {item.quantity}</p>
                <p>Prix unitaire : {formatPrice(unitPrice)} €</p>
                <p>Sous-total : {subtotal !== null ? formatPrice(subtotal) : 'N/A'} €</p>
              </div>
            </div>
          );
        })}
      </div>

      <div className="order-total mt-4">
        <strong>Total de la commande : {formatPrice(order.total)} €</strong>
      </div>

      <div className="mt-4">
        <Link to="/orders" className="btn btn-secondary">← Retour à mes commandes</Link>
      </div>
    </div>
  );
};

export default OrderDetail;
