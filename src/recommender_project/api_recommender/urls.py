from django.conf.urls import url

from . import views


urlpatterns  = [
    url(r'^view-movies/',views.RecommenderApiView.as_view()),
]
