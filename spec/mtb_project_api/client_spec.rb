module MtbProjectApi
  RSpec.describe Client do
    let(:root_url) { 'https://www.mtbproject.com/data' }
    let(:email) { 'pigdog@email.com' }
    let(:private_key) { 'mtb_project_private_key' }

    let(:response_body) { "response_body" }

    subject { Client.new(email, private_key) }

    shared_examples_for 'a valid request' do |client_method|
      it "passes response body to Oj" do
        expect(Oj).to receive(:load).with(response_body)

        subject.send(client_method, params)
      end
    end

    shared_examples_for 'request with ids' do |client_method|
      context 'with id array' do
        before do
          stub_request(:get, "#{root_url}/#{client_method.to_s.gsub!(/_/, '-')}")
            .with(query: request_params)
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', client_method do
          let(:ids) { [41321, 123123, 123123] }
          let(:params) { { ids: ids } }
          let(:request_params) do
            { ids: ids.join(',') }.merge(key: private_key)
          end
        end
      end

      context 'with no ids' do
        before do
          stub_request(:get, "#{root_url}/#{client_method.to_s.gsub!(/_/, '-')}")
            .with(query: request_params)
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', client_method do
          let(:params) { {} }
          let(:request_params) { { ids: "", key: private_key } }
        end
      end

      context 'with single id' do
        before do
          stub_request(:get, "#{root_url}/#{client_method.to_s.gsub!(/_/, '-')}")
            .with(query: request_params)
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', client_method do
          let(:params) { { ids: 980934 } }
          let(:request_params) { params.merge(key: private_key) }
        end
      end
    end

    describe '#get_local_trails' do
      context 'with valid params' do
        before do
          stub_request(:get, "#{root_url}/get-trails")
            .with(query: params.merge(key: private_key))
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_local_trails do
          let(:params) do
            { lat: 40.0274,
              lon: -105.2519,
              maxDistance: 10 }
          end
        end
      end

      context 'with invalid params' do
        before do
          stub_request(:get, "#{root_url}/get-trails")
            .with(query: valid_params.merge(key: private_key))
            .to_return(status: 200, body: response_body, headers: {})
        end

        it_should_behave_like 'a valid request', :get_local_trails do
          let(:valid_params) do
            {
              lat: 40.0274,
              lon: -105.2519
            }
          end

          let(:invalid_params) do
            {
              pigdog: "best dog in the world",
              bikes: 8943
            }
          end

          let(:params) { valid_params.merge(invalid_params) }
        end
      end
    end

    describe '#get_trails_by_id' do
      it_should_behave_like 'request with ids', :get_trails_by_id
    end

    describe '#get_conditions' do
      it_should_behave_like 'request with ids', :get_conditions
    end

    describe '#get_to_dos' do
      before do
        stub_request(:get, "#{root_url}/get-to-dos")
          .with(query: { email: email, key: private_key })
          .to_return(status: 200, body: response_body, headers: {})
      end

      it_should_behave_like 'a valid request', :get_to_dos do
        let(:params) { {} }
      end
    end
  end
end
