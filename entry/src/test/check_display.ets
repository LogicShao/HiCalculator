/**
 * 复数显示验证脚本
 * 直接运行查看格式化结果
 */
import { ComplexCalculator } from '../main/ets/utils/Complex';
import { ExpressionEvaluator } from '../main/ets/utils/ExpressionEvaluator';

console.info('\n=================================================');
console.info('复数显示格式化验证');
console.info('=================================================\n');

// 测试1: 明确虚部为0的情况
console.info('===== 测试1: 虚部为0 =====');
console.info('Complex(3, 0) → "' + ComplexCalculator.format({ real: 3, imag: 0 }) + '"');
console.info('Complex(-5, 0) → "' + ComplexCalculator.format({ real: -5, imag: 0 }) + '"');
console.info('Complex(0, 0) → "' + ComplexCalculator.format({ real: 0, imag: 0 }) + '"');
console.info('Complex(3.5, 0) → "' + ComplexCalculator.format({ real: 3.5, imag: 0 }) + '"');

// 测试2: 纯虚数
console.info('\n===== 测试2: 纯虚数 =====');
console.info('Complex(0, 1) → "' + ComplexCalculator.format({ real: 0, imag: 1 }) + '"');
console.info('Complex(0, -1) → "' + ComplexCalculator.format({ real: 0, imag: -1 }) + '"');
console.info('Complex(0, 3) → "' + ComplexCalculator.format({ real: 0, imag: 3 }) + '"');

// 测试3: 复数
console.info('\n===== 测试3: 复数 =====');
console.info('Complex(3, 2) → "' + ComplexCalculator.format({ real: 3, imag: 2 }) + '"');
console.info('Complex(5, -3) → "' + ComplexCalculator.format({ real: 5, imag: -3 }) + '"');

// 测试4: 表达式结果
console.info('\n===== 测试4: 表达式求值结果 =====');
console.info('"3 × 2" → "' + ExpressionEvaluator.formatResult('3 × 2') + '"');
console.info('"5 + 0 × 3" → "' + ExpressionEvaluator.formatResult('5 + 0 × 3') + '"');
console.info('"6 ÷ 2" → "' + ExpressionEvaluator.formatResult('6 ÷ 2') + '"');

console.info('\n===== 测试5: 复数表达式 =====');
console.info('"2 + 3j + 4 + 0j" → "' + ExpressionEvaluator.formatResult('2 + 3j + 4 + 0j') + '"');
console.info('"3j × 0" → "' + ExpressionEvaluator.formatResult('3j × 0') + '"');

console.info('\n=================================================\n');
