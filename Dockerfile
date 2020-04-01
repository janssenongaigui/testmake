FROM python:3.9.0a5-buster

## Step 1:
WORKDIR /app

## Step 2:
COPY . app.py /app/
COPY . static /app/

## Step 3:
# hadolint ignore=DL3013
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Expose port 80
EXPOSE 80

# Run app.py at container launch
CMD ["python", "app.py"]