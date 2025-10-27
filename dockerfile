# Step 1: Use an official Python image as base
FROM python:3.10-slim

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy all files from your project to the container
COPY . /app

# Step 4: Install dependencies (if you have requirements.txt)
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Command to run your app
CMD ["python", "app.py"]
