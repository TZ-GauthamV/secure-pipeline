# ✅ Use newer, patched base image
FROM python:3.11-slim

# 🔐 Security + stability env flags
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# 📦 Upgrade system dependencies first (reduces CVEs)
RUN apt-get update && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 📦 Install dependencies
COPY requirements.txt .

# Upgrade pip first (important for security fixes)
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# 📥 Copy application code
COPY . .

# 🚪 Expose app port
EXPOSE 80

# ▶️ Run app
CMD ["python", "app.py"]
