FROM python:3.7.0-slim-stretch

# Create user account
RUN useradd --create-home --system headline
USER headline

WORKDIR /srv/headline

# Install packages
COPY --chown=headline requirements.txt requirements.txt
RUN pip install --user --no-warn-script-location --requirement requirements.txt

# Copy application
COPY --chown=headline headline headline

# Run application
ENV FLASK_APP headline
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0"]
