import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

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

const ProductList = () => {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const res = await axios.get('http://localhost:8000/api/products/');
        // Ajouter une image aléatoire à chaque produit
        const productsWithImages = res.data.map(product => ({
          ...product,
          image: getRandomImage()
        }));
        setProducts(productsWithImages);
      } catch (err) {
        setError('Erreur lors du chargement des produits. Veuillez réessayer plus tard.');
        console.error('Erreur lors du chargement des produits:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  if (loading) {
    return (
      <div className="container">
        <div className="loading">Chargement des produits...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container">
        <div className="message message-error">{error}</div>
      </div>
    );
  }

  return (
    <div className="container">
      <h1 className="page-title">Nos Produits</h1>
      <div className="products-grid">
        {products.map(product => (
          <Link to={`/product/${product.id}`} key={product.id} className="card product-card">
            <img 
              src={product.image}
              alt={product.name}
              className="product-image"
            />
            <div className="product-card-content">
              <h2 className="product-card-title">{product.name}</h2>
              <p className="product-card-description">{product.description}</p>
              <div className="product-card-footer">
                <span className="product-card-price">{product.price} €</span>
              </div>
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
};

export default ProductList;
