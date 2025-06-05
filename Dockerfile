FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Install uv for dependency management
RUN pip install --no-cache-dir --root-user-action=ignore uv==0.5.18

# Copy project files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
RUN uv sync --frozen

# Copy the rest of the application
COPY __main__.py ./

# Set environment variables (can be overridden at runtime)
ENV FREQTRADE_API_URL=http://freqtrade:8080
ENV FREQTRADE_USERNAME=Freqtrader
ENV FREQTRADE_PASSWORD=SuperSecret1!

# Run the MCP server
CMD ["uv", "run", "mcp", "run", "."]