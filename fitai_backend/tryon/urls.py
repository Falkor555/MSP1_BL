from django.urls import path
from .views import TryOnListCreateView, TryOnDetailView

urlpatterns = [
    path('', TryOnListCreateView.as_view(), name='tryon-list-create'),
    path('<uuid:id>/', TryOnDetailView.as_view(), name='tryon-detail'),
]