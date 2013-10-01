shared_examples 'an error' do |error|
  error_class_name = error.split(/_/).map{ |word| word.capitalize }.join('')
  exception = Lieu.const_get(error_class_name)

  it "raising #{exception.name} when status is #{error}" do
    VCR.turn_off!

    endpoint = 'bigboombadaboum'

    stub_get(endpoint).to_return(
      body: { status: error }.to_json,
      headers: json_content_type
    )

    expect { client.get(endpoint) }.to raise_error exception

    VCR.turn_on!
  end
end

shared_examples 'a http error' do |status_code, exception|
  it "raising #{exception.name} when http status code is #{status_code}" do
    VCR.turn_off!

    endpoint = 'bigboombadaboum'

    stub_get(endpoint).to_return(status: status_code)

    expect { client.get(endpoint) }.to raise_error exception

    VCR.turn_on!
  end
end
