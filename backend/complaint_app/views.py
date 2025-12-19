from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Complaint
from .serializers import ComplaintSerializer

@api_view(['GET'])
def get_complaints(request):
    complaints = Complaint.objects.all().order_by('-id')
    serializer = ComplaintSerializer(complaints, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def add_complaint(request):
    serializer = ComplaintSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response({"message": "Complaint Submitted"})
    return Response(serializer.errors, status=400)
