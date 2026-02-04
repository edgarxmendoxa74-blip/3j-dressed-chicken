import React, { useState, useEffect } from 'react';
import { UtensilsCrossed, Coffee, Heart } from 'lucide-react';
import { Link } from 'react-router-dom';
import { supabase } from '../supabaseClient';

const About = () => {
    const [storeSettings, setStoreSettings] = useState({
        store_name: '3J Dressed Chicken Store',
        logo_url: ''
    });

    useEffect(() => {
        const fetchStoreSettings = async () => {
            const { data } = await supabase.from('store_settings').select('*').limit(1).single();
            if (data) setStoreSettings(data);
        };
        fetchStoreSettings();
    }, []);

    return (
        <div className="page-wrapper">
            <header className="app-header">
                <div className="container header-container">
                    <Link to="/" className="brand">
                        <img src={storeSettings.logo_url || "/logo.jpg"} alt="3J Logo" style={{ height: '60px' }} />

                    </Link>
                    <nav className="header-nav" style={{ display: 'flex', gap: '20px' }}>
                        <Link to="/" className="nav-link">Home</Link>

                        <Link to="/contact" className="nav-link">Contact</Link>
                    </nav>
                </div>
            </header>

            <main className="container" style={{ padding: '80px 0' }}>
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '60px', alignItems: 'center', marginBottom: '80px' }}>
                    <div>
                        <h1 style={{ fontSize: '3.5rem', marginBottom: '20px', fontWeight: 900 }}>Our <span style={{ color: 'var(--primary)' }}>Story</span></h1>
                        <p style={{
                            fontFamily: 'Playfair Display, serif',
                            fontSize: '1.2rem',
                            color: 'var(--primary)',
                            fontWeight: 700,
                            fontStyle: 'italic',
                            marginBottom: '20px'
                        }}>
                            Matinlo kag Garantisado
                        </p>
                        <h2 style={{ fontSize: '2.5rem', marginBottom: '30px', color: 'var(--primary)' }}>Freshness You Can Trust</h2>
                        <p style={{ marginBottom: '20px', lineHeight: '1.8' }}>
                            {storeSettings.store_name} was founded on the principle of providing the community with the freshest, highest-quality poultry and meat products. We believe that freshness should be affordable and accessible to every household.
                        </p>
                        <p style={{ lineHeight: '1.8' }}>
                            Our dressed chickens are sourced from trusted local farms, handled with strict hygienic standards, and delivered fresh daily. Whether you're looking for whole chicken, specific cuts, or marinated ready-to-cook items, we ensure that every product meets our premium quality standards.
                        </p>
                    </div>
                    <img src="https://images.unsplash.com/photo-1587593817658-30230303ceda?auto=format&fit=crop&w=800&q=80" alt="Fresh Chicken Store" style={{ width: '100%', borderRadius: '20px', boxShadow: 'var(--shadow-lg)' }} />
                </div>

            </main>
        </div>
    );
};

export default About;
