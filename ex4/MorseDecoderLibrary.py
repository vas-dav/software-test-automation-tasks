import serial

class MorseDecoderLibrary(object):
    ''' Library for interacting with morse sender and decoder
    '''

    def __init__(self, sender_port, decoder_port):
        self._sender = serial.Serial(sender_port, 115200, timeout = 1)
        self._decoder = serial.Serial(decoder_port, 115200, timeout = 20)

    def set_speed(self, speed):
        self._sender.write(bytes('wpm ' + speed + '\n', 'utf-8'))


    def send_text(self, text):
        self._decoder.reset_input_buffer()
        self._sender.write(bytes("text " + text + '\n', 'utf-8'))

    def speed_should_be_in_range(self, expected_range):
        self._decoder.write(bytes('WPM' + '\n', 'utf-8'))
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        max_lim = speed + int(expected_range)
        min_lim = speed - int(expected_range)
        if speed > max_lim or speed < min_lim:
            raise AssertionError('Expected +/-: ' + str(expected_range) + ' got: '  + str(speed) + ' line: ' + text)

    def speed_should_be(self, expected_speed):
        self._decoder.write(bytes('WPM' + '\n', 'utf-8'))
        text = self._decoder.readline().strip().decode('utf-8')
        speed = int(text.split()[2])
        if speed != int(expected_speed):
            raise AssertionError('Expected: ' + str(expected_speed) + ' got: '  + str(speed) + ' line: ' + text)


    def text_should_be(self, expected_text):
        text = self._decoder.readline().strip().decode('utf-8')
        if text != expected_text:
            raise AssertionError('Expected: ' + expected_text + ' got: ' + text)


    def set_auto_wpm_status(self, status):
        self._decoder.write(bytes('WPM ' + str(status) + '\n', 'utf-8'))


    def set_immediate_status(self, status):
        self._decoder.write(bytes('IMM ' + str(status) + '\n', 'utf-8'))


    def auto_wpm_status_should_be(self, expected_status):
        expected_str = '[ Print WPM is ' + expected_status + ' ]'
        text = self._decoder.readline().strip().decode('utf-8')
        if text != expected_str:
            raise AssertionError('Expected: ' + expected_str + ' got: ' + text)


    def immediate_status_should_be(self, expected_status):
        expected_str = '[ Immediate output is ' + expected_status + ' ]'
        text = self._decoder.readline().strip().decode('utf-8')
        if text != expected_str:
            raise AssertionError('Expected: ' + expected_str + ' got: ' + text)

