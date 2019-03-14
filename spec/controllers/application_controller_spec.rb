require_relative '../spec_helper.rb'

RSpec.describe ApplicationController, type: :controller do
  it 'should allow accessing the home page' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to include('Welcome')
  end

  it 'should show the 404 page' do
    get '/unknown_route'

    expect(last_response).to be_not_found
    expect(last_response.body).to include('404')
  end
end
