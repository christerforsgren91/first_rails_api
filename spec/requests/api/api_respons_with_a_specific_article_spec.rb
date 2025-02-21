RSpec.describe 'GET /api/articles/:id' do
  describe 'successfully' do
    let!(:article) { create(:article, title: 'This is the latest news', body: 'And this is some mind blowing content') }
    
    before do
      get "/api/articles/#{article.id}"
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the requested articles title' do
      expect(response_json['article']['title']).to eq 'This is the latest news'
    end

    it 'is expected to return the requested articles body' do
      expect(response_json['article']['body']).to eq 'And this is some mind blowing content'
    end
  end

  describe 'unsuccessfully with invalid id' do
    before do
      get '/api/articles/abc'
    end

    it 'is expected to return 404 status' do
      expect(response).to have_http_status 404
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Unfortunately we can not find the article you are looking for.'
    end
  end
end