# Dockerfile

# Use an official Ruby runtime as the base image
FROM ruby:3.2.2

# Update the repositories list
RUN apt-get update

# Install Node.js and npm
RUN apt-get install -y nodejs npm

# Set working directory inside the container
WORKDIR /usr/src/blog

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the Rails application code into the container
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

