/**
 * ComplexCalculator 显示格式测试
 * 验证虚部为0时是否只显示实部
 */
import { describe, it, expect } from '@ohos/hypium';
import { ComplexCalculator } from '../../main/ets/utils/Complex';

export default function complexDisplayTest() {
  describe('ComplexDisplayTest', () => {
    /**
     * 测试虚部为0时只显示实部
     */
    it('testFormat_realOnly', 0, () => {
      // 3 + 0j 应该显示为 "3"
      let result = ComplexCalculator.format({ real: 3, imag: 0 });
      console.info('3 + 0j 格式化结果: "' + result + '"');
      expect(result).assertEqual('3');

      // -5 + 0j 应该显示为 "-5"
      result = ComplexCalculator.format({ real: -5, imag: 0 });
      console.info('-5 + 0j 格式化结果: "' + result + '"');
      expect(result).assertEqual('-5');

      // 0 + 0j 应该显示为 "0"
      result = ComplexCalculator.format({ real: 0, imag: 0 });
      console.info('0 + 0j 格式化结果: "' + result + '"');
      expect(result).assertEqual('0');
    });

    /**
     * 测试纯虚数
     */
    it('testFormat_imaginaryOnly', 0, () => {
      // 0 + j 应该显示为 "j"
      let result = ComplexCalculator.format({ real: 0, imag: 1 });
      console.info('0 + 1j 格式化结果: "' + result + '"');
      expect(result).assertEqual('j');

      // 0 + 3j 应该显示为 "3j"
      result = ComplexCalculator.format({ real: 0, imag: 3 });
      console.info('0 + 3j 格式化结果: "' + result + '"');
      expect(result).assertEqual('3j');

      // 0 - 2j 应该显示为 "-2j"
      result = ComplexCalculator.format({ real: 0, imag: -2 });
      console.info('0 - 2j 格式化结果: "' + result + '"');
      expect(result).assertEqual('-2j');
    });

    /**
     * 测试复数
     */
    it('testFormat_complex', 0, () => {
      // 3 + 2j 应该显示为 "3 + 2j"
      let result = ComplexCalculator.format({ real: 3, imag: 2 });
      console.info('3 + 2j 格式化结果: "' + result + '"');
      let normalized = result.replace(/\s+/g, ' ').trim();
      expect(normalized).assertEqual('3 + 2j');

      // 5 - 3j 应该显示为 "5 - 3j"
      result = ComplexCalculator.format({ real: 5, imag: -3 });
      console.info('5 - 3j 格式化结果: "' + result + '"');
      normalized = result.replace(/\s+/g, ' ').trim();
      expect(normalized).assertEqual('5 - 3j');
    });

    /**
     * 测试浮点数结果
     */
    it('testFormat_floatingPoint', 0, () => {
      // 3.5 + 0j 应该显示为 "3.5"
      let result = ComplexCalculator.format({ real: 3.5, imag: 0 });
      console.info('3.5 + 0j 格式化结果: "' + result + '"');
      expect(result).assertEqual('3.5');

      // 测试 2.1 + 0j * 2 = 4.2 + 0j
      let calcResult = { real: 2.1 * 2, imag: 0 };
      result = ComplexCalculator.format(calcResult);
      console.info('4.2 + 0j 格式化结果: "' + result + '"');
      expect(result).assertEqual('4.2');
    });

    /**
     * 测试 ExpressionEvaluator 的结果
     */
    it('testFormat_expressionResult', 0, () => {
      import { ExpressionEvaluator } from '../../main/ets/utils/ExpressionEvaluator';

      // 测试 (2 + 0j) * 3 = 6 + 0j
      let expr = '2 × 3';
      let result = ExpressionEvaluator.formatResult(expr);
      console.info('表达式 "' + expr + '" 结果: "' + result + '"');

      // 测试 (2 + j) * (2 - j) = 5 + 0j (共轭复数相乘)
      // 实际计算: (2 + j) * (2 - j) = 4 - 2j + 2j - j² = 4 - (-1) = 5
      // 因为 j² = -1
    });
  });
}
