require 'rails_helper'

describe MoviesController do

    before :each do
      @fake_movie = FactoryGirl::create(:movie)
    end

 describe 'updating director info' do
   before :each do
     allow(Movie).to receive(:find).with(@fake_movie.id.to_s).and_return(@fake_movie)
   end

   it 'should call update_attributes and redirect' do
     allow(@fake_movie).to receive(:update_attributes!).and_return(true)
     put :update, {:id => @fake_movie.id, :movie => @fake_movie.attributes}
     response.should redirect_to(movie_path(@fake_movie))
   end
  end

describe 'update the total attributes! ' do
  let (:attr) do
   {:director => "new content" }
  end

  before :each do
    put :update, {:id => @fake_movie.id.to_s, :movie => attr}
    @fake_movie.reload
  end


   it 'should update the actual attributes!?'do

       expect(response).to redirect_to(@fake_movie)
      expect(@fake_movie.director).to eql attr[:director ]
    end
  end #update movie end

end #controller end
