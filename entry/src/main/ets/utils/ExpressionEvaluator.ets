/**
 * 表达式求值器
 * 支持包含多个操作数和运算符的表达式计算
 * 自动处理运算符优先级
 */
import { Complex, ComplexCalculator } from './Complex'

/**
 * 运算符信息接口
 */
interface OperatorInfo {
  precedence: number // 优先级，数值越大优先级越高
  associativity: 'left' | 'right' // 结合性
  operation: (a: Complex, b: Complex) => Complex // 运算函数
}

/**
 * 表达式求值类
 */
export class ExpressionEvaluator {
  // 运算符优先级表
  private static operators: Map<string, OperatorInfo> = new Map<string, OperatorInfo>([
    ['+', { precedence: 1, associativity: 'left', operation: ComplexCalculator.add } as OperatorInfo],
    ['-', { precedence: 1, associativity: 'left', operation: ComplexCalculator.subtract } as OperatorInfo],
    ['×', { precedence: 2, associativity: 'left', operation: ComplexCalculator.multiply } as OperatorInfo],
    ['÷', { precedence: 2, associativity: 'left', operation: ComplexCalculator.divide } as OperatorInfo]
  ])

  /**
   * 判断是否为运算符
   */
  private static isOperator(token: string): boolean {
    return ExpressionEvaluator.operators.has(token)
  }

  /**
   * 获取运算符优先级
   */
  private static getPrecedence(op: string): number {
    return ExpressionEvaluator.operators.get(op)?.precedence || 0
  }

  /**
   * 比较两个运算符的优先级
   * 如果 op1 优先级低于或等于 op2，返回 true
   */
  private static comparePrecedence(op1: string, op2: string): boolean {
    const p1 = ExpressionEvaluator.getPrecedence(op1)
    const p2 = ExpressionEvaluator.getPrecedence(op2)
    const assoc1 = ExpressionEvaluator.operators.get(op1)?.associativity || 'left'

    if (assoc1 === 'left') {
      return p1 <= p2
    } else {
      return p1 < p2
    }
  }

  /**
   * 将中缀表达式转换为后缀表达式（RPN - 逆波兰表示法）
   * 使用调度场算法（Shunting-yard algorithm）
   *
   * @param infixExpr 中缀表达式字符串
   * @returns 后缀表达式数组（令牌列表）
   */
  private static infixToRPN(infixExpr: string): string[] {
    const outputQueue: string[] = []
    const operatorStack: string[] = []
    const tokens = ExpressionEvaluator.tokenize(infixExpr)

    for (const token of tokens) {
      if (ExpressionEvaluator.isOperator(token)) {
        // 如果是运算符
        while (
          operatorStack.length > 0 &&
          ExpressionEvaluator.isOperator(operatorStack[operatorStack.length - 1]) &&
          ExpressionEvaluator.comparePrecedence(token, operatorStack[operatorStack.length - 1])
        ) {
          outputQueue.push(operatorStack.pop()!)
        }
        operatorStack.push(token)
      } else {
        // 如果是操作数（复数），直接加入输出队列
        outputQueue.push(token)
      }
    }

    // 将栈中剩余的运算符全部弹出到输出队列
    while (operatorStack.length > 0) {
      outputQueue.push(operatorStack.pop()!)
    }

    return outputQueue
  }

  /**
   * 将表达式字符串切分为令牌（tokens）
   * 支持：数字、复数、运算符
   * 能够正确处理复数（如"3+4j"）、小数（"3.14"）和负数
   */
  private static tokenize(expr: string): string[] {
    const tokens: string[] = []
    const trimmedExpr = expr.trim()

    if (trimmedExpr === '') {
      return tokens
    }

    let currentToken = ''
    let i = 0

    while (i < trimmedExpr.length) {
      const char = trimmedExpr[i]
      if (ExpressionEvaluator.isOperator(char)) {
        // 如果遇到运算符，先处理当前令牌
        if (currentToken.trim() !== '') {
          tokens.push(currentToken.trim())
          currentToken = ''
        }
        tokens.push(char)
        i++
      } else if (char === 'j') {
        // 遇到虚数单位，将其作为当前令牌的一部分
        if (currentToken === '') {
          // 单独的 "j"
          tokens.push('j')
        } else {
          // 与其他数字组合的 "j"（如 "3j"）
          currentToken += char
          tokens.push(currentToken)
          currentToken = ''
        }
        i++
      } else if (char === '.') {
        // 小数点，如果前一个字符是数字或在令牌内，则继续累积
        currentToken += char
        i++
      } else {
        // 数字或其他字符（包括用于负数或复数的'-'）
        if (char === '-' && currentToken === '' && tokens.length > 0) {
          // 检查前一个令牌是否是运算符，如果是，则这可能是负数
          if (!ExpressionEvaluator.isOperator(tokens[tokens.length - 1])) {
            tokens.push(tokens[tokens.length - 1]) // 重复前一个令牌（错误情况）
          }
        }
        currentToken += char
        i++
      }
    }

    // 添加最后一个令牌
    if (currentToken.trim() !== '') {
      tokens.push(currentToken.trim())
    }

    return tokens
  }

  /**
   * 计算后缀表达式的值
   *
   * @param rpnExpr 后缀表达式数组
   * @returns 复数结果
   */
  private static evaluateRPN(rpnExpr: string[]): Complex {
    const stack: Complex[] = []
    for (const token of rpnExpr) {
      if (ExpressionEvaluator.isOperator(token)) {
        // 如果是运算符，从栈中弹出两个操作数
        if (stack.length < 2) {
          throw new Error('Invalid expression: insufficient operands')
        }

        const b = stack.pop()!
        const a = stack.pop()!
        const opInfo = ExpressionEvaluator.operators.get(token)

        if (!opInfo) {
          throw new Error(`Unknown operator: ${token}`)
        }
        try {
          const result = opInfo.operation(a, b)
          stack.push(result)
        } catch (error) {
          throw new Error(error instanceof Error ? error.message : String(error))
        }
      } else {
        // 如果是操作数，解析为复数并入栈
        const value = ComplexCalculator.parse(token)
        stack.push(value)
      }
    }

    // 计算完成后，栈中应该只剩一个元素
    if (stack.length !== 1) {
      throw new Error(`Invalid expression: too many operands, stack has ${stack.length} items`)
    }

    return stack[0]
  }

  /**
   * 评估表达式的值
   * 支持完整表达式，自动处理运算符优先级
   *
   * @param expr 表达式字符串，如 "3 + 4 × 2"
   * @returns 复数结果
   * @throws Error 当表达式无效时
   */
  static evaluate(expr: string): Complex {
    if (!expr || expr.trim() === '') {
      return { real: 0, imag: 0 }
    }
    try {
      // 1. 转换为后缀表达式
      const rpnExpr = ExpressionEvaluator.infixToRPN(expr)

      // 2. 求值
      return ExpressionEvaluator.evaluateRPN(rpnExpr)
    } catch (error) {
      throw new Error(error instanceof Error ? error.message : String(error))
    }
  }

  /**
   * 验证表达式是否有效
   *
   * @param expr 表达式字符串
   * @returns true如果有效
   */
  static isValid(expr: string): boolean {
    try {
      ExpressionEvaluator.evaluate(expr)
      return true
    } catch {
      return false
    }
  }

  /**
   * 格式化表达式结果
   *
   * @param expr 表达式字符串
   * @returns 格式化后的字符串结果
   */
  static formatResult(expr: string): string {
    try {
      const result = ExpressionEvaluator.evaluate(expr)
      return ComplexCalculator.format(result)
    } catch (error) {
      return 'Error!'
    }
  }
}
