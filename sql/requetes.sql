
-- Q1.5 : Requêtes SQL

-- 1. Afficher tous les produits
SELECT * FROM produits;

-- 2. Afficher les produits en rupture de stock
SELECT * FROM produits
WHERE quantite = 0;

-- 3. Trier les produits par prix décroissant
SELECT * FROM produits
ORDER BY prix DESC;

-- 4. Afficher les produits avec leurs catégories
SELECT produits.nom AS produit, categories.nom AS categorie
FROM produits
INNER JOIN categories
ON produits.categorie_id = categories.id;

-- 5. Compter les produits par catégorie
SELECT categories.nom AS categorie,
       COUNT(produits.id) AS nombre_produits
FROM categories
LEFT JOIN produits ON categories.id = produits.categorie_id
GROUP BY categories.id, categories.nom;

-- 6. Calculer la valeur totale du stock
SELECT SUM(prix * quantite) AS valeur_totale_stock
FROM produits;
