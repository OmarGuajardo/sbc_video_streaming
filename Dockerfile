FROM python:3.9.6
WORKDIR /app
COPY ./requirements-omar.txt /app
RUN pip install --upgrade pip
RUN pip install -r requirements-omar.txt
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
COPY . .
EXPOSE 5000 
CMD ["python", "app.py", "--host", "0.0.0.0"]
