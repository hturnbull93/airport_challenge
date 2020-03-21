require 'airport'

describe Airport do

  let(:boeing) { Plane.new }
  let(:learjet) { Plane.new }
  let(:large_airport) { Airport.new(15) }

  context '#land' do
    it 'responds' do
      expect(subject).to respond_to :land
    end
    it 'expects one argument' do
      expect(subject).to respond_to(:land).with(1).argument
    end
    it 'returns a Plane object' do
      expect(subject.land(boeing)).to be_instance_of(Plane)
    end
    it 'returns the same Plane object that was passed in' do
      expect(subject.land(boeing)).to be boeing
    end
    it 'stores the landed plane in the hangar' do
      subject.land(boeing)
      expect(subject.hangar).to include boeing
    end
    it 'raises error if @hanger is full' do
      5.times {subject.land(Plane.new)}
      expect { subject.land(learjet) }.to raise_error 'Hangar full.'
    end
  end

  context '#take_off' do
    it 'responds' do
      expect(subject).to respond_to :take_off
    end
    it 'expects one argument' do
      expect(subject).to respond_to(:take_off).with(1).argument
    end
    it 'returns a Plane object' do
      expect(subject.take_off(boeing)).to be_instance_of(Plane)
    end
    it 'returns the same Plane object that was passed in to confirm take off' do
      expect(subject.take_off(boeing)).to be boeing
    end
  end

  context '@hangar' do
    it 'responds' do
      expect(subject).to respond_to :hangar
    end
    it 'returns landed planes' do
      subject.land(boeing)
      subject.land(learjet)
      expect(subject.hangar).to include(boeing, learjet)
    end
  end

  context '@capacity' do
    it 'when not set, default is 5, landing more than 5 will raise error' do
      5.times { subject.land(Plane.new) }
      expect { subject.land(learjet) }.to raise_error 'Hangar full.'
    end
    it 'when set to 15, landing more than 15 will raise error' do
      15.times { large_airport.land(Plane.new) }
      expect { large_airport.land(learjet) }.to raise_error 'Hangar full.'
    end
  end

end
