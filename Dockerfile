FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    --no-install-recommends && \
    apt-get clean

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip setuptools
RUN pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

COPY . .
CMD ["python", "app.py"]
