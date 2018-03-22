from rest_framework import serializers


class RecommenderSerializer(serializers.Serializer):
    """Serializer moviename field as input to API"""

    moviename = serializers.CharField(min_length=1,allow_blank=False)

    email = serializers.EmailField(min_length=4, allow_blank=False)
