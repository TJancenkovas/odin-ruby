#spec/caesar_cipher_spec.rb

require './lib/caesar_cipher.rb'

describe 'Cipher' do
  it 'returns the original unciphered text' do
    expect(caesar_cipher('What the dog doing?')).to eql('What the dog doing?')
  end

  it 'returns forward ciphered text' do
    expect(caesar_cipher('Aa aa', 1)).to eql('Bb bb')
  end

  it 'returns forward looped ciphered text' do
    expect(caesar_cipher('Yy zz', 2)).to eql('Aa bb')
  end

  it 'returns backwards ciphered text' do
    expect(caesar_cipher('Ll ll', -1)).to eql('Kk kk')
  end

  it 'returns backwards looped ciphered text' do
    expect(caesar_cipher('Bb aa', -2)).to eql('Zz yy')
  end
end
