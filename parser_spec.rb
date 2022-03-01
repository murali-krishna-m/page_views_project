require 'rspec'
require_relative 'parser'

describe Parser do
  context 'creating' do
    context 'when the given file is not found' do
      it 'Returns error when not found' do
        filename = 'test_data1.log'
        expect { ReadLogFileService.new(filename) }.to raise_error(StandardError)
      end
    end
  end

  it 'Returns the hash of pages and its views' do
    filename = 'test_data.log'
    expected_output = {
      '/about' => 3,
      '/about/2' => 3,
      '/contact' => 4,
      '/help_page/1' => 3,
      '/home' => 3,
      '/index' => 3
    }
    parser = Parser.new(filename)
    expect(parser.page_views).to eql(expected_output)
  end

  it 'Returns the hash of pages and its unique views' do
    filename = 'test_data.log'
    expected_output = {
      '/about' => 3,
      '/about/2' => 3,
      '/contact' => 4,
      '/help_page/1' => 2,
      '/home' => 2,
      '/index' => 3
    }
    parser = Parser.new(filename)
    expect(parser.unique_page_views).to eql(expected_output)
  end
end