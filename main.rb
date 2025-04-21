class FourBitCPU
  def initialize(rom)
    @pc = 0
    @register_a = 0
    @register_b = 0
    @carry_flag = false
    @input = 0
    @output = 0
    @rom = rom
  end

  def run
    loop do
      instruction = fetch
      decode(instruction)
      sleep(0.5) # Simulate a clock cycle
    end
  end

  def fetch
    instruction = @rom[@pc]
    @pc += 1
    instruction
  end

  def decode(instruction)
    immediate = instruction & 0x0F
    case instruction & 0xF0
    when 0x00
      add_immediate_to_a(immediate)
    when 0x50
      add_immediate_to_b(immediate)
    end
  end

  def add_immediate_to_a(value)
    result = @register_a + value
    @carry_flag = result > 0x0F
    @register_a = result & 0x0F
    puts "Register A: #{@register_a}, Carry: #{@carry_flag}"
  end

  def add_immediate_to_b(value)
    result = @register_b + value
    @carry_flag = result > 0x0F
    @register_b = result & 0x0F
    puts "Register B: #{@register_b}, Carry: #{@carry_flag}"
  end
end

ROM = [0x0A, 0x01, 0x0A]

cpu = FourBitCPU.new(ROM)

cpu.run


