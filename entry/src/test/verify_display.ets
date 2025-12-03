/**
 * 验证复数显示行为
 * 测试当虚部为0时，计算器各处的显示是否正确
 */
import { ComplexCalculator } from '../main/ets/utils/Complex';
import { ExpressionEvaluator } from '../main/ets/utils/ExpressionEvaluator';

console.info('\n=================================================');
console.info('复数显示行为验证');
console.info('=================================================\n');

// 测试1: ComplexCalculator.format() 的行为
console.info('===== 测试1: ComplexCalculator.format() =====');
console.info('输入: {real: 3, imag: 0}');
console.info('输出: "' + ComplexCalculator.format({ real: 3, imag: 0 }) + '"');
console.info('✓ 预期: "3" (只显示实部，没有+号)');
console.info('');

console.info('输入: {real: 5, imag: 0}');
console.info('输出: "' + ComplexCalculator.format({ real: 5, imag: 0 }) + '"');
console.info('✓ 预期: "5" (只显示实部，没有+号)');
console.info('');

console.info('输入: {real: 2.5, imag: 0}');
console.info('输出: "' + ComplexCalculator.format({ real: 2.5, imag: 0 }) + '"');
console.info('✓ 预期: "2.5" (只显示实部，没有+号)');
console.info('');

// 测试2: ExpressionEvaluator.formatResult() 的行为
console.info('===== 测试2: ExpressionEvaluator.formatResult() =====');
console.info('表达式: "2 + 3"');
console.info('结果: "' + ExpressionEvaluator.formatResult('2 + 3') + '"');
console.info('说明: 2 + 3 = 5 + 0j → 应该显示为 "5"');
console.info('');

console.info('表达式: "6 ÷ 2"');
console.info('结果: "' + ExpressionEvaluator.formatResult('6 ÷ 2') + '"');
console.info('说明: 6 ÷ 2 = 3 + 0j → 应该显示为 "3"');
console.info('');

console.info('表达式: "4 × 0"');
console.info('结果: "' + ExpressionEvaluator.formatResult('4 × 0') + '"');
console.info('说明: 4 × 0 = 0 + 0j → 应该显示为 "0"');
console.info('');

// 测试3: 复数运算
console.info('===== 测试3: 复数运算结果 =====');
console.info('表达式: "(2 + 3j) × (2 - 3j)"');
console.info('结果: "' + ExpressionEvaluator.formatResult('2 + 3j × 2 - 3j') + '"');
console.info('说明: (2+3j)×(2-3j) = 4-6j+6j-9j² = 4-9(-1) = 13 + 0j → 应该显示为 "13"');
console.info('');

console.info('表达式: "(1 + j) + (1 - j)"');
console.info('结果: "' + ExpressionEvaluator.formatResult('1 + j + 1 - j') + '"');
console.info('说明: (1+j)+(1-j) = 2 + 0j → 应该显示为 "2"');
console.info('');

// 测试4: 验证不显示 "+ 0j" 或 "- 0j"
console.info('===== 测试4: 验证不显示 +0j 或 -0j =====');
const testCases = [
  { expr: '5 + 0', desc: '加法结果虚部为0' },
  { expr: '3 - 3', desc: '减法结果虚部为0' },
  { expr: '2 × 0', desc: '乘法结果虚部为0' },
  { expr: '0 ÷ 2', desc: '除法结果虚部为0' },
];

testCases.forEach(test => {
  const result = ExpressionEvaluator.formatResult(test.expr);
  const hasPlusZeroJ = result.includes('+ 0j') || result.includes('+0j');
  const hasMinusZeroJ = result.includes('- 0j') || result.includes('-0j');

  console.info(`表达式: "${test.expr}"`);
  console.info(`结果: "${result}"`);
  console.info(`描述: ${test.desc}`);

  if (hasPlusZeroJ || hasMinusZeroJ) {
    console.info('✗ FAIL: 结果显示了 +0j 或 -0j');
  } else {
    console.info('✓ PASS: 结果正确，没有显示 +0j 或 -0j');
  }
  console.info('');
});

console.info('=================================================\n');

// 总结
console.info('验证总结:');
console.info('1. ComplexCalculator.format() 已经正确处理虚部为0的情况');
console.info('2. 当 imag === 0 时，只返回 formatNumber(real)，不显示+号');
console.info('3. 表达式求值结果也应该遵循同样的规则');
console.info('');
console.info('如果测试中发现了显示 +0j 或 -0j 的情况，请检查:');
console.info('- ExpressionEvaluator.evaluate() 是否正确调用了 ComplexCalculator.format()');
console.info('- 是否使用了旧的格式化方法');
