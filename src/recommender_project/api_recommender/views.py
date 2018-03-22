from django.shortcuts import render

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from . import serializers

from .ml_module import test
#from . import ml_module.test as ml_test
# Create your views here.

class RecommenderApiView(APIView):
    """API View to recommend movies based on user input"""
    serializer_class = serializers.RecommenderSerializer

    def post(self,request):
        """Post API to get recommended movies"""

        serializer = serializers.RecommenderSerializer(data=request.data)

        if serializer.is_valid():
            moviename = serializer.data.get('moviename')
            userEmail =  serializer.data.get('email')
            ml_module = test.adder(moviename,userEmail); #include code in this ml_module folder and call it from here

            message    = 'You have provided the movie name {0}. Will email relevant suggestions to {1}'.format(moviename,userEmail)

            return Response({'message':message,'ml_test':ml_module})

        else:
            return Response(
                serializer.errors,status = status.HTTP_400_BAD_REQUEST)
