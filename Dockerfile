FROM python:3.9.6
WORKDIR /app
COPY ./requirements.txt /app
RUN pip3 install -r requirements.txt
COPY . .
EXPOSE 5000 
ENV FLASK_APP=main.py
CMD ["python3", "main.py", "--host", "0.0.0.0"]
