require 'rails_helper'

describe MoviesController do

    before :each do
      @fake_movie = FactoryGirl::create(:movie)
      @fake_movie2 = FactoryGirl::create(:movie)
      @fake_movie3 = FactoryGirl::create(:movie)
      @fake_results = [@fake_movie3, @fake_movie2]
      @empty_dir_movie = FactoryGirl::create(:no_dir_movie)
    end

 describe 'updating director info' do
   before :each do
     allow(Movie).to receive(:find).with(@fake_movie.id.to_s).and_return(@fake_movie)
   end

   it 'should call update_attributes and redirect' do
     allow(@fake_movie).to receive(:update_attributes!).and_return(true)
     put :update, {:id => @fake_movie.id, :movie => @fake_movie.attributes}
     expect(response).to redirect_to(movie_path(@fake_movie))
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

  describe 'happy path' do
    before :each do
      allow(Movie).to receive(:similar_directors).with(@fake_movie.director).and_return(@fake_results)
    end

    it 'should go to the route for simliar movies' do
      expect route_to(:controller => 'movies', :action => 'similar', :movie_id => @fake_movie.id.to_s)
      {:post => movie_similar_path(@fake_movie.id.to_s)}
    end

    it 'should call the model method that finds similar movies' do
      get :similar, {:movie_id => @fake_movie.id.to_s}
    end

    it 'should render the similar template with the similar movies' do
      get :similar, {:movie_id => @fake_movie.id.to_s}
      expect(response).to render_template('similar')
    end

    it 'should assign the instance variable @movies correctly' do
      get :similar, {:movie_id => @fake_movie.id.to_s}
      expect(assigns(:movies)) == @fake_results
    end

  end

  describe 'sad path' do
    before :each do
     allow(Movie).to receive(:find).with(@empty_dir_movie.id.to_s).and_return(@empty_dir_movie)
    end

    it 'should generate routing for simliar movies' do
      expect route_to(:controller => 'movies', :action => 'similar', :movie_id => @empty_dir_movie.id.to_s)
      {:post => movie_similar_path(@empty_dir_movie.id.to_s)}
    end

    it 'should return to home page w flash message' do
      get :similar, {:movie_id => @empty_dir_movie.id.to_s}
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to_not be_blank
    end

  end

end #controller end
