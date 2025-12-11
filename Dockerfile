FROM python:3.12-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

#Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system tools
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter + nbconvert
RUN pip install jupyter nbconvert kaggle

# Create kaggle directory inside the container
RUN mkdir -p /root/.kaggle

# Copy the repo contents
COPY . .

# Make the data folder available
RUN mkdir -p data

CMD ["bash"]


