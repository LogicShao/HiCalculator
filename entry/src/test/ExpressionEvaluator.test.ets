/**
 * ExpressionEvaluator 测试用例
 * 测试表达式求值器的各种功能
 */
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { ExpressionEvaluator } from '../../main/ets/utils/ExpressionEvaluator';

/**
 * 测试套件入口
 */
export default function expressionEvaluatorTest() {
  describe('ExpressionEvaluatorTest', () => {
    beforeAll(() => {
      console.info('ExpressionEvaluator 测试套件开始');
    });

    afterAll(() => {
      console.info('ExpressionEvaluator 测试套件完成');
    });

    /**
     * 基本算术运算测试
     */
    it('testBasicArithmetic_addition', 0, () => {
      let result = ExpressionEvaluator.formatResult('3 + 5');
      expect(result).assertEqual('8');
    });

    it('testBasicArithmetic_subtraction', 0, () => {
      let result = ExpressionEvaluator.formatResult('10 - 4');
      expect(result).assertEqual('6');
    });

    it('testBasicArithmetic_multiplication', 0, () => {
      let result = ExpressionEvaluator.formatResult('6 × 7');
      expect(result).assertEqual('42');
    });

    it('testBasicArithmetic_division', 0, () => {
      let result = ExpressionEvaluator.formatResult('15 ÷ 3');
      expect(result).assertEqual('5');
    });

    it('testBasicArithmetic_decimal', 0, () => {
      let result = ExpressionEvaluator.formatResult('3.5 + 2.5');
      expect(result).assertEqual('6');
    });

    /**
     * 运算符优先级测试
     */
    it('testOperatorPrecedence_multiplicationOverAddition', 0, () => {
      let result = ExpressionEvaluator.formatResult('3 + 4 × 2');
      expect(result).assertEqual('11');
    });

    it('testOperatorPrecedence_divisionOverAddition', 0, () => {
      let result = ExpressionEvaluator.formatResult('10 + 6 ÷ 2');
      expect(result).assertEqual('13');
    });

    it('testOperatorPrecedence_multipleOperators', 0, () => {
      let result = ExpressionEvaluator.formatResult('5 + 3 × 2 - 4');
      expect(result).assertEqual('7');
    });

    it('testOperatorPrecedence_consecutiveOperations', 0, () => {
      let result = ExpressionEvaluator.formatResult('12 ÷ 2 × 3');
      expect(result).assertEqual('18');
    });

    it('testOperatorPrecedence_complexExpression', 0, () => {
      let result = ExpressionEvaluator.formatResult('20 - 4 × 3 + 10 ÷ 2');
      expect(result).assertEqual('18');
    });

    it('testOperatorPrecedence_manyOperands', 0, () => {
      let result = ExpressionEvaluator.formatResult('2 + 3 + 4 + 5');
      expect(result).assertEqual('14');
    });

    /**
     * 复数表达式测试
     */
    it('testComplexExpressions_addition', 0, () => {
      let result = ExpressionEvaluator.formatResult('3 + 4j + 2 + 5j');
      // 规范化空格后比较
      let normalized = result.replace(/\s+/g, ' ').trim();
      expect(normalized).assertEqual('5 + 9j');
    });

    it('testComplexExpressions_subtraction', 0, () => {
      let result = ExpressionEvaluator.formatResult('5 + 8j - 2 - 3j');
      let normalized = result.replace(/\s+/g, ' ').trim();
      expect(normalized).assertEqual('3 + 5j');
    });

    it('testComplexExpressions_multiplication', 0, () => {
      let result = ExpressionEvaluator.formatResult('2 + 3j × 4');
      let normalized = result.replace(/\s+/g, ' ').trim();
      expect(normalized).assertEqual('8 + 12j');
    });

    it('testComplexExpressions_imaginarySquare', 0, () => {
      let result = ExpressionEvaluator.formatResult('j × j');
      expect(result).assertEqual('-1');
    });

    it('testComplexExpressions_division', 0, () => {
      let result = ExpressionEvaluator.formatResult('6 + 4j ÷ 2');
      let normalized = result.replace(/\s+/g, ' ').trim();
      expect(normalized).assertEqual('3 + 2j');
    });

    /**
     * 边界情况测试
     */
    it('testEdgeCases_singleNumber', 0, () => {
      let result = ExpressionEvaluator.formatResult('42');
      expect(result).assertEqual('42');
    });

    it('testEdgeCases_twoOperands', 0, () => {
      let result = ExpressionEvaluator.formatResult('100 ÷ 4');
      expect(result).assertEqual('25');
    });

    it('testEdgeCases_pi', 0, () => {
      let result = ExpressionEvaluator.formatResult('3.14159');
      expect(result).assertEqual('3.14159');
    });

    it('testEdgeCases_imaginaryUnit', 0, () => {
      let result = ExpressionEvaluator.formatResult('j');
      expect(result).assertEqual('j');
    });

    it('testEdgeCases_imaginaryMultiple', 0, () => {
      let result = ExpressionEvaluator.formatResult('3j');
      expect(result).assertEqual('3j');
    });

    /**
     * 错误处理测试
     */
    it('testErrorHandling_empty', 0, () => {
      let result = ExpressionEvaluator.formatResult('');
      expect(result).assertEqual('0');
    });

    it('testErrorHandling_divideByZero', 0, () => {
      let result = ExpressionEvaluator.formatResult('10 ÷ 0');
      expect(result).assertEqual('Error!');
    });
  });
}
