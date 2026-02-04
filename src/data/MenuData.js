export const categories = [
    { id: 'fresh-chicken', name: 'Fresh Chicken' },
    { id: 'frozen-goods', name: 'Frozen Goods' },
    { id: 'marinated', name: 'Marinated Items' },
    { id: 'ready-to-eat', name: 'Ready to Eat' },
];

export const menuItems = [
    // Fresh Chicken
    {
        id: 1,
        categoryId: 'fresh-chicken',
        name: 'Whole Dressed Chicken',
        description: 'Premium quality fresh dressed chicken.',
        price: 220,
        image: 'https://images.unsplash.com/photo-1606787366850-de6330128bfc?auto=format&fit=crop&w=400&q=80',
        variations: [
            { name: 'Regular Size', price: 210 },
            { name: 'Large Size', price: 230 }
        ]
    },
    {
        id: 2,
        categoryId: 'fresh-chicken',
        name: 'Chicken Breast (Boneless)',
        description: 'Fresh boneless chicken breast, perfect for fillets.',
        price: 260,
        image: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=400&q=80',
        variations: [
            { name: '500g', price: 140 },
            { name: '1kg', price: 260 }
        ]
    },
    // Marinated
    {
        id: 3,
        categoryId: 'marinated',
        name: 'Marinated Roast Chicken',
        description: 'Ready-to-bake chicken with our secret spice blend.',
        price: 320,
        promoPrice: 299,
        image: 'https://images.unsplash.com/photo-1594464083313-2dc704bb43c8?auto=format&fit=crop&w=400&q=80',
        flavors: ['Classic Garlic', 'Spicy BBQ', 'Honey Soy']
    },
    {
        id: 4,
        categoryId: 'marinated',
        name: 'Chicken Wings (Buffalo Style)',
        description: 'Marinated wings ready for frying or baking.',
        price: 180,
        image: 'https://images.unsplash.com/photo-1527477396000-e27163b481c2?auto=format&fit=crop&w=400&q=80',
        variations: [
            { name: 'Set of 6', price: 180 },
            { name: 'Set of 12', price: 340 }
        ]
    },
    // Frozen Goods
    {
        id: 5,
        categoryId: 'frozen-goods',
        name: 'Chicken Nuggets',
        description: 'Premium frozen chicken nuggets for kids and snacks.',
        price: 150,
        image: 'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=400&q=80',
        variations: [
            { name: '250g', price: 85 },
            { name: '500g', price: 150 }
        ]
    },
    {
        id: 6,
        categoryId: 'frozen-goods',
        name: 'Chicken Longganisa',
        description: 'Authentic Filipino style frozen chicken sausage.',
        price: 120,
        image: 'https://images.unsplash.com/photo-1541518763669-27f714620583?auto=format&fit=crop&w=400&q=80',
        variations: [
            { name: 'Standard Pack', price: 120 },
            { name: 'Family Pack', price: 220 }
        ]
    }
];
