/**
 * 复数类
 * 提供复数的解析、格式化显示和基本运算功能
 */
export interface Complex {
  real: number;
  imag: number;
}

/**
 * 复数计算器类
 * 封装复数的解析、格式化和运算逻辑
 */
export class ComplexCalculator {
  /**
   * 将字符串解析为复数对象
   * 支持的格式:
   * - "j" (1j)
   * - "2j" (2j)
   * - "-3j" (-3j)
   * - "3+4j" (3 + 4j)
   * - "2-3j" (2 - 3j)
   * - "5" (5 + 0j)
   *
   * @param value 复数字符串
   * @returns Complex对象
   */
  static parse(value: string): Complex {
    const cleanValue = value.trim()

    // 纯虚数，如 "j", "2j", "-3j"
    if (cleanValue === 'j' || /^[+-]?\d*\.?\d*j$/.test(cleanValue)) {
      const imagPart = cleanValue === 'j' ? 1 :
        cleanValue === '-j' ? -1 :
          parseFloat(cleanValue.replace(/j$/, '') || (cleanValue.startsWith('-') ? '-1' : '1'))
      return { real: 0, imag: imagPart }
    }

    // "a + bj" 或 "a - bj" 格式
    const match = cleanValue.match(/^([+-]?\d*\.?\d*)\s*([+-])\s*(\d*\.?\d*)j$/)
    if (match) {
      const real = parseFloat(match[1] || '0') || 0
      const imag = parseFloat((match[2] === '-' ? '-' : '') + (match[3] || '1')) || 0
      return { real, imag }
    }

    // 纯实数
    const realValue = parseFloat(cleanValue)
    if (!isNaN(realValue)) {
      return { real: realValue, imag: 0 }
    }

    // 返回零，表示解析失败
    return { real: 0, imag: 0 }
  }

  /**
   * 将复数转换为字符串表示
   * 输出格式:
   * - 0 → "0"
   * - 3 → "3"
   * - 2j → "2j"
   * - j → "j"
   * - 3+4j → "3 + 4j"
   * - 2-3j → "2 - 3j"
   *
   * @param c 复数对象
   * @returns 格式化字符串
   */
  static format(c: Complex): string {
    const real = c.real
    const imag = c.imag

    // 纯实数
    if (imag === 0) {
      return ComplexCalculator.formatNumber(real)
    }

    // 纯虚数
    if (real === 0) {
      if (imag === 1) {
        return 'j'
      }
      if (imag === -1) {
        return '-j'
      }
      return `${ComplexCalculator.formatNumber(imag)}j`
    }

    // 复数
    if (imag > 0) {
      if (imag === 1) {
        return `${ComplexCalculator.formatNumber(real)} + j`
      }
      return `${ComplexCalculator.formatNumber(real)} + ${ComplexCalculator.formatNumber(imag)}j`
    } else {
      if (imag === -1) {
        return `${ComplexCalculator.formatNumber(real)} - j`
      }
      return `${ComplexCalculator.formatNumber(real)} - ${ComplexCalculator.formatNumber(Math.abs(imag))}j`
    }
  }

  /**
   * 复数加法: (a + bj) + (c + dj) = (a+c) + (b+d)j
   *
   * @param a 第一个复数
   * @param b 第二个复数
   * @returns a + b
   */
  static add(a: Complex, b: Complex): Complex {
    return {
      real: a.real + b.real,
      imag: a.imag + b.imag
    }
  }

  /**
   * 复数减法: (a + bj) - (c + dj) = (a-c) + (b-d)j
   *
   * @param a 第一个复数
   * @param b 第二个复数
   * @returns a - b
   */
  static subtract(a: Complex, b: Complex): Complex {
    return {
      real: a.real - b.real,
      imag: a.imag - b.imag
    }
  }

  /**
   * 复数乘法: (a + bj) × (c + dj) = (ac - bd) + (ad + bc)j
   *
   * @param a 第一个复数
   * @param b 第二个复数
   * @returns a × b
   */
  static multiply(a: Complex, b: Complex): Complex {
    return {
      real: a.real * b.real - a.imag * b.imag,
      imag: a.real * b.imag + a.imag * b.real
    }
  }

  /**
   * 复数除法: (a + bj) ÷ (c + dj) = ((ac + bd) + (bc - ad)j) / (c² + d²)
   * 若除数为零，抛出错误
   *
   * @param a 被除数
   * @param b 除数
   * @returns a ÷ b
   * @throws Error 当除数为零时
   */
  static divide(a: Complex, b: Complex): Complex {
    // 检查除零错误
    if (b.real === 0 && b.imag === 0) {
      throw new Error('Division by zero')
    }

    const denominator = b.real * b.real + b.imag * b.imag
    return {
      real: (a.real * b.real + a.imag * b.imag) / denominator,
      imag: (a.imag * b.real - a.real * b.imag) / denominator
    }
  }

  /**
   * 复制复数对象
   *
   * @param c 源复数
   * @returns 副本
   */
  static clone(c: Complex): Complex {
    return { real: c.real, imag: c.imag }
  }

  /**
   * 判断两个复数是否相等
   *
   * @param a 第一个复数
   * @param b 第二个复数
   * @returns true如果相等
   */
  static equals(a: Complex, b: Complex): boolean {
    return a.real === b.real && a.imag === b.imag
  }

  /**
   * 判断复数是否为零
   *
   * @param c 复数
   * @returns true如果为零
   */
  static isZero(c: Complex): boolean {
    return c.real === 0 && c.imag === 0
  }

  /**
   * 格式化数字，控制精度和范围
   * 处理极大或极小数字，限制小数位数
   *
   * @param num 数字
   * @returns 格式化字符串
   */
  private static formatNumber(num: number): string {
    if (!Number.isFinite(num)) {
      return 'Error!'
    }

    // 处理极大或极小的数字
    if (Math.abs(num) > 1e15) {
      return num.toExponential(6)
    }

    // 处理小数精度
    let str = num.toString()

    // 如果是小数，限制小数位数
    if (str.includes('.')) {
      const parts = str.split('.')
      if (parts[1].length > 10) {
        str = num.toFixed(10)
        // 去除末尾多余的0
        str = str.replace(/\.?0+$/, '')
      }
    }

    // 限制总长度
    if (str.length > 15) {
      if (str.includes('.')) {
        // 如果是小数，截断小数部分
        const parts = str.split('.')
        const integerPart = parts[0]
        const decimalPart = parts[1]
        const maxDecimalLength = Math.max(0, 14 - integerPart.length)
        str = integerPart + '.' + decimalPart.substring(0, maxDecimalLength)
      } else {
        // 如果是整数，使用科学计数法
        str = num.toExponential(6)
      }
    }

    return str
  }
}
