
FROM python:3.10-alpine3.15

# The error suggests that the container exited before becoming healthy. 
# To investigate the issue, we need to define a healthcheck for the container.

# Update the package manager and install the required dependencies.
RUN apk update && apk add --no-cache python3-dev build-base && pip install --upgrade pip

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY requirements.txt .

# Install the Python dependencies
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Expose port 8000
EXPOSE 8000

# Define a healthcheck command to verify if the container is running properly
HEALTHCHECK --interval=5s CMD curl -f http://localhost:8000/ || exit 1

# Set the default command to run the "run.py" file
CMD ["python3", "run.py"]
