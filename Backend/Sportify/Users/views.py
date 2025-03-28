from django.contrib.auth import authenticate
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.hashers import make_password
from rest_framework_simplejwt.tokens import RefreshToken

from .models import CustomUser
from .serializers import CustomUserSerializer  # Assurez-vous de créer un serializer pour CustomUser

@api_view(['POST'])
def register_view (request):
    if request.method == 'POST':
        data = request.data.copy()
        password = data.get('password')

        if not password:
            return Response({'error': 'Password is required'}, status=status.HTTP_400_BAD_REQUEST)

        hashed_password = make_password(password)
        data['password'] = hashed_password

        user_serializer = CustomUserSerializer(data=data)

        if user_serializer.is_valid():
            user = user_serializer.save()

            return Response({'message': 'User registered successfully'}, status=status.HTTP_201_CREATED)

        return Response(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def login_view(request):
    email = request.data.get('email')
    password = request.data.get('password')

    if not email or not password:
        return Response({'error': 'Email and password are required'}, status=status.HTTP_400_BAD_REQUEST)

    user = authenticate(request, username=email, password=password)

    if user is not None:
        refresh = RefreshToken.for_user(user)
        return Response({
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }, status=status.HTTP_200_OK)

    return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)