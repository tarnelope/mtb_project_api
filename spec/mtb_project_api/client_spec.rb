module MtbProjectApi
  RSpec.describe Client do
    let(:root_url) { 'https://www.mtbproject.com/data' }
    let(:email) { 'pigdog@email.com' }
    let(:private_key) { 'mtb_project_private_key' }

    let(:response_body) { "response_body" }

    subject { Client.new(email, private_key) }

    shared_examples_for 'a valid request' do |client_method, params|
      it "passes response body to Oj" do
        expect(Oj).to receive(:load).with(response_body)
        if params
          subject.send(client_method, params)
        else
          subject.send(client_method)
        end
      end
    end

    describe '#get_local_trails' do
      context 'with valid params' do
        params = { lat: 40.0274,
                   lon: -105.2519,
                   maxDistance: 10 }

        before do
          stub_request(:get, "#{root_url}/get-trails")
            .with(query: params.merge(key: private_key))
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_local_trails, params
      end

      context 'with invalid params' do
        valid_params = {
          lat: 40.0274,
          lon: -105.2519
        }

        invalid_params = {
          pigdog: "best dog in the world",
          bikes: 8943
        }

        params = valid_params.merge(invalid_params)

        before do
          stub_request(:get, "#{root_url}/get-trails")
            .with(query: valid_params.merge(key: private_key))
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_local_trails, params
      end

    end

    describe '#get_trails_by_id' do
      context 'with id array' do
        ids = [41321, 123123, 123123]
        params = { ids: ids }

        before do
          stub_request(:get, "#{root_url}/get-trails-by-id")
            .with(query: { ids: ids.join(',') }.merge(key: private_key))
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_trails_by_id, params
      end

      context 'with no ids' do
        before do
          stub_request(:get, "#{root_url}/get-trails-by-id")
            .with(query: { ids: "", key: private_key })
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_trails_by_id, {}
      end

      context 'with single id' do
        params = { ids: 980934 }

        before do
          stub_request(:get, "#{root_url}/get-trails-by-id")
            .with(query: { ids: 980934, key: private_key })
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_trails_by_id, params
      end
    end

    describe '#get_conditions' do
      
    end

    describe '#get_to_dos' do
      before do
        stub_request(:get, "#{root_url}/get-to-dos")
          .with(query: { email: email, key: private_key })
          .to_return(status: 200, body: response_body, headers: {})
      end

      it_should_behave_like 'a valid request', :get_to_dos
    end
  end
end
