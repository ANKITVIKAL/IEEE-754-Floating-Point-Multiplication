
# Half-Precision Floating-Point Multiplier in Verilog

## Overview

This repository contains the implementation of a **Half-Precision Floating-Point Multiplier** in Verilog, compliant with the IEEE 754-2019 standard. The module performs multiplication on 16-bit floating-point numbers, classifies the operands, and handles edge cases such as NaNs, infinities, zeros, subnormal numbers, and normal numbers.

### Key Features

- **IEEE 754-2019 Compliance**:
  - Handles special cases: sNaN, qNaN, infinities, zeros, subnormal, and normal numbers.
  - Accurate computation of product sign using the XOR of operand signs.
- **Operand Classification**:
  - Uses a dedicated module (`hp_class`) to classify operands into various categories as per IEEE 754.
- **Significand Multiplication**:
  - Computes the raw product of significands and adjusts for normalization.
- **Edge Case Handling**:
  - Graceful handling of overflow, underflow, and rounding.
- **Compact Representation**:
  - Produces a 16-bit output in IEEE 754 half-precision format.

## File Structure

- `hp_mul.v`: Contains the Verilog code for the half-precision floating-point multiplier.
- `hp_class.v`: (If available) A submodule to classify the floating-point operands based on IEEE 754 standards.
- `testbench_hp_mul.v`: (Optional) A testbench for verifying the functionality of the multiplier.

## Inputs and Outputs

### Inputs:
- `a` (16-bit): First half-precision floating-point operand.
- `b` (16-bit): Second half-precision floating-point operand.

### Outputs:
- `p` (16-bit): Result of the multiplication in IEEE 754 half-precision format.
- Flags (1-bit each):
  - `snan`: Signaling NaN.
  - `qnan`: Quiet NaN.
  - `infinity`: Indicates infinity result.
  - `zero`: Indicates zero result.
  - `subnormal`: Indicates subnormal result.
  - `normal`: Indicates normal result.

## Functionality

The module implements the following functionality:
1. **Sign Determination**:
   - The sign of the result is computed as the XOR of the signs of the two inputs.
2. **Operand Classification**:
   - The operands are classified as NaN, infinity, zero, subnormal, or normal using the `hp_class` module.
3. **Special Cases**:
   - Proper handling of cases such as NaN propagation, multiplication by zero, infinity handling, and subnormal results.
4. **Normalization and Rounding**:
   - Adjusts the product's significand and exponent to ensure the result adheres to IEEE 754 specifications.

## Example Usage

```verilog
module tb_hp_mul;
  reg [15:0] a, b;
  wire [15:0] p;
  wire snan, qnan, infinity, zero, subnormal, normal;

  hp_mul uut (
    .a(a),
    .b(b),
    .p(p),
    .snan(snan),
    .qnan(qnan),
    .infinity(infinity),
    .zero(zero),
    .subnormal(subnormal),
    .normal(normal)
  );

  initial begin
    a = 16'h3C00; // Example: 1.0 in IEEE 754 half-precision
    b = 16'h4000; // Example: 2.0 in IEEE 754 half-precision
    #10;
    $display("Result: %h, Flags - snan: %b, qnan: %b, infinity: %b, zero: %b, subnormal: %b, normal: %b", 
             p, snan, qnan, infinity, zero, subnormal, normal);
  end
endmodule
```

## Testing

- Ensure to test edge cases such as:
  - `0 × infinity`
  - `NaN × any number`
  - `subnormal × normal`
  - Overflow and underflow conditions.
- Use a Verilog simulator (e.g., ModelSim, Xilinx Vivado) for functional verification.

## Future Improvements

- Add support for configurable rounding modes.
- Extend the design for higher precision formats (e.g., single-precision, double-precision).
- Optimize for performance and resource usage on FPGA/ASIC implementations.


