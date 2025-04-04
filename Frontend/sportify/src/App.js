import React, { useContext } from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import Home from './components/Home';
import RegisterForm from './components/RegisterForm';
import LoginForm from './components/LoginForm';
import ProductList from './components/ProductList';
import ProductDetail from './components/ProductDetail';
import Cart from './components/Cart';
import OrderHistory from './components/OrderHistory';
import OrderDetail from './components/OrderDetail'; // ✅ import du composant OrderDetail
import Footer from './components/Footer';
import { AuthContext } from './context/AuthContext';
import './App.css';

function App() {
  const { user, logout } = useContext(AuthContext);

  return (
    <Router>
      <div className="app">
        <nav className="navbar">
          <div className="container navbar-container">
            <Link to="/" className="navbar-brand">Sportify</Link>
            <div className="navbar-menu">
              <Link to="/" className="navbar-link">Accueil</Link>
              <Link to="/products" className="navbar-link">Produits</Link>
              {user ? (
                <>
                  <Link to="/cart" className="navbar-link">Panier</Link>
                  <Link to="/orders" className="navbar-link">Mes commandes</Link>
                  <div className="user-menu">
                    <span className="user-name">👤 {user}</span>
                    <button onClick={logout} className="btn btn-primary">Déconnexion</button>
                  </div>
                </>
              ) : (
                <>
                  <Link to="/register" className="btn btn-primary">Inscription</Link>
                  <Link to="/login" className="btn btn-primary">Connexion</Link>
                </>
              )}
            </div>
          </div>
        </nav>

        <main className="container">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/register" element={<RegisterForm />} />
            <Route path="/login" element={<LoginForm />} />
            <Route path="/products" element={<ProductList />} />
            <Route path="/product/:id" element={<ProductDetail />} />
            <Route path="/cart" element={<Cart />} />
            <Route path="/orders" element={<OrderHistory />} />
            <Route path="/orders/:orderId" element={<OrderDetail />} /> {/* ✅ nouvelle route */}
          </Routes>
        </main>

        <Footer />
      </div>
    </Router>
  );
}

export default App;
