import React from 'react';
import { Link } from 'react-router-dom';

const Footer = () => {
    return (
      <footer className="footer">
        <div className="footer-content">
          <div className="footer-section">
            <h3>À propos de Sportify</h3>
            <p>Votre destination pour tous vos besoins en équipement sportif. Qualité, service et passion du sport.</p>
          </div>
          
          <div className="footer-section">
            <h3>Navigation</h3>
            <ul>
              <li><Link to="/">Accueil</Link></li>
              <li><Link to="/products">Produits</Link></li>
              <li><Link to="/cart">Panier</Link></li>
              <li><Link to="/orders">Mes commandes</Link></li>
            </ul>
          </div>
          
          <div className="footer-section">
            <h3>Catégories</h3>
            <ul>
              <li><Link to="/products">Football</Link></li>
              <li><Link to="/products">Basketball</Link></li>
              <li><Link to="/products">Running</Link></li>
              <li><Link to="/products">Fitness</Link></li>
            </ul>
          </div>
          
          <div className="footer-section">
            <h3>Contact</h3>
            <ul>
              <li>📞 01 23 45 67 89</li>
              <li>📧 contact@sportify.com</li>
              <li>📍 123 Rue du Sport, Paris</li>
            </ul>
          </div>
        </div>
        
        <div className="footer-bottom">
          <p>&copy; 2024 Sportify. Tous droits réservés.</p>
          <div className="footer-social">
            <a href="#" aria-label="Facebook">📱</a>
            <a href="#" aria-label="Twitter">🐦</a>
            <a href="#" aria-label="Instagram">📸</a>
          </div>
        </div>
      </footer>
    );
  };

export default Footer;