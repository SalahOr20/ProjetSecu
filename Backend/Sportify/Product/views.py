from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from .models import Product, Order, OrderItem
from .serializer import ProductSerializer, OrderSerializer, OrderItemSerializer


# Créer un produit
@api_view(['POST'])
def create_product(request):
    if request.method == 'POST':
        serializer = ProductSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# Obtenir la liste des produits
@api_view(['GET'])
def list_products(request):
    products = Product.objects.all()
    serializer = ProductSerializer(products, many=True)
    return Response(serializer.data)

# Obtenir un produit spécifique
@api_view(['GET'])
def get_product(request, product_id):
    try:
        product = Product.objects.get(id=product_id)
        serializer = ProductSerializer(product)
        return Response(serializer.data)
    except Product.DoesNotExist:
        return Response({'error': 'Product not found'}, status=status.HTTP_404_NOT_FOUND)

# Mettre à jour un produit
@api_view(['PUT'])
def update_product(request, product_id):
    try:
        product = Product.objects.get(id=product_id)
        serializer = ProductSerializer(product, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except Product.DoesNotExist:
        return Response({'error': 'Product not found'}, status=status.HTTP_404_NOT_FOUND)

# Supprimer un produit
@api_view(['DELETE'])
def delete_product(request, product_id):
    try:
        product = Product.objects.get(id=product_id)
        product.delete()
        return Response({'message': 'Product deleted'}, status=status.HTTP_204_NO_CONTENT)
    except Product.DoesNotExist:
        return Response({'error': 'Product not found'}, status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
def create_order(request):
    user = request.user
    product_ids = request.data.get('product_ids', [])
    quantities = request.data.get('quantities', [])

    if not product_ids or not quantities or len(product_ids) != len(quantities):
        return Response({"error": "Invalid product data"}, status=status.HTTP_400_BAD_REQUEST)

    # Créer la commande
    order = Order.objects.create(user=user)

    # Ajouter les produits à la commande
    for product_id, quantity in zip(product_ids, quantities):
        try:
            product = Product.objects.get(id=product_id)
        except Product.DoesNotExist:
            return Response({"error": f"Product with id {product_id} not found"}, status=status.HTTP_404_NOT_FOUND)

        order_item = OrderItem.objects.create(
            order=order,
            product=product,
            quantity=quantity
        )

    order.calculate_total()

    serializer = OrderSerializer(order)
    return Response(serializer.data, status=status.HTTP_201_CREATED)


@api_view(['GET'])
def get_user_orders(request):
    """Récupérer toutes les commandes d'un utilisateur basé sur son token"""

    if not request.user.is_authenticated:
        return Response({"error": "Authentication credentials were not provided."}, status=status.HTTP_401_UNAUTHORIZED)

    user = request.user  # L'utilisateur connecté via le token

    # Filtrer les commandes de l'utilisateur
    orders = Order.objects.filter(user=user)

    if not orders:
        return Response({"error": "No orders found for this user"}, status=status.HTTP_404_NOT_FOUND)

    # Sérialiser les commandes
    orders_serializer = OrderSerializer(orders, many=True)

    # Ajouter les items de chaque commande
    for order_data in orders_serializer.data:
        order_id = order_data['id']
        order_items = OrderItem.objects.filter(order_id=order_id)

        # Sérialiser les items de la commande
        order_items_serializer = OrderItemSerializer(order_items, many=True)

        # Ajouter les items de la commande dans la réponse
        order_data['order_items'] = order_items_serializer.data

    return Response(orders_serializer.data, status=status.HTTP_200_OK)