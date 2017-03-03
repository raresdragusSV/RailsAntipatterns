class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = @pet.find_cute_toys
  end
end

# using Proxy Association
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = @pet.toys.cute
  end
end

# using simple association
class PetsController < ApplicationController
  def show
    @pet = Pet.find(params[:id])
    @toys = @pet.toys.cute.paginate(params[:page])
  end
end
