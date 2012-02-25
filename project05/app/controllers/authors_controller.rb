class AuthorsController < ApplicationController
  respond_to :html
  # even cool would be to detect a normal ModelController class name
  # and have it inherit from something like ResourcefulController
  controls :authors
end
