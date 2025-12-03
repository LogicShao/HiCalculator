import { Complex, ComplexCalculator } from '../utils/Complex'
import { ExpressionEvaluator } from '../utils/ExpressionEvaluator'

@Entry
@Component
struct Index {
  @State displayValue: string = '0'
  @State firstOperand: Complex = { real: 0, imag: 0 }
  @State operator: string = ''
  @State waitingForSecondOperand: boolean = false
  @State hasError: boolean = false
  @State mode: 'real' | 'complex' = 'real' // 计算器模式：实数或复数
  @State expression: string = '' // 当前表达式
  @State showExpression: boolean = false // 是否显示表达式

  // 数字按钮点击处理
  handleNumberInput(number: string): void {
    if (this.hasError) {
      this.handleClear()
    }

    // 如果之前是运算符，开始新的操作数
    if (this.waitingForSecondOperand || this.expression !== '') {
      this.displayValue = number
      this.waitingForSecondOperand = false
    } else {
      // 限制数字长度，防止溢出
      if (this.displayValue.length < 15) {
        this.displayValue = this.displayValue === '0' ? number : this.displayValue + number
      }
    }
  }

  // 运算符按钮点击处理
  handleOperator(nextOperator: string): void {
    if (this.hasError) {
      return
    }

    // 将当前值添加到表达式
    if (this.displayValue) {
      this.expression += this.displayValue + ' ' + nextOperator + ' '
    }

    this.waitingForSecondOperand = true
    this.operator = nextOperator
    this.showExpression = true
  }

  // 执行复数计算
  performComplexCalculation(): Complex {
    const inputValue = ComplexCalculator.parse(this.displayValue)

    try {
      switch (this.operator) {
        case '+':
          return ComplexCalculator.add(this.firstOperand, inputValue)
        case '-':
          return ComplexCalculator.subtract(this.firstOperand, inputValue)
        case '×':
          return ComplexCalculator.multiply(this.firstOperand, inputValue)
        case '÷':
          return ComplexCalculator.divide(this.firstOperand, inputValue)
        default:
          return inputValue
      }
    } catch (error) {
      // 捕获除零错误
      this.showError()
      return { real: 0, imag: 0 }
    }
  }

  // 执行计算（兼容旧代码）
  performCalculation(): number {
    const inputValue = parseFloat(this.displayValue)

    switch (this.operator) {
      case '+':
        return this.addNumbers(this.firstOperand.real, inputValue)
      case '-':
        return this.subtractNumbers(this.firstOperand.real, inputValue)
      case '×':
        return this.multiplyNumbers(this.firstOperand.real, inputValue)
      case '÷':
        return this.divideNumbers(this.firstOperand.real, inputValue)
      default:
        return inputValue
    }
  }

  // 加法运算
  addNumbers(a: number, b: number): number {
    const result = a + b
    // 检查是否溢出
    if (!Number.isFinite(result)) {
      this.showError()
      return 0
    }
    return result
  }

  // 减法运算
  subtractNumbers(a: number, b: number): number {
    const result = a - b
    if (!Number.isFinite(result)) {
      this.showError()
      return 0
    }
    return result
  }

  // 乘法运算
  multiplyNumbers(a: number, b: number): number {
    const result = a * b
    if (!Number.isFinite(result)) {
      this.showError()
      return 0
    }
    return result
  }

  // 除法运算
  divideNumbers(a: number, b: number): number {
    // 检查除零错误
    if (b === 0) {
      this.showError()
      return 0
    }
    const result = a / b
    if (!Number.isFinite(result)) {
      this.showError()
      return 0
    }
    return result
  }

  // 显示错误
  showError(): void {
    this.displayValue = 'Error!'
    this.hasError = true
  }

  // 数字格式化，控制精度和范围
  formatNumber(num: number): string {
    if (!Number.isFinite(num)) {
      this.showError()
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

  // 等号按钮点击处理
  handleEquals(): void {
    if (this.hasError) {
      return
    }

    // 如果有累积的表达式，使用表达式求值器计算
    if (this.expression !== '') {
      // 将当前显示的数值添加到表达式末尾
      const fullExpr = this.expression + this.displayValue

      try {
        // 使用表达式求值器计算结果
        this.displayValue = ExpressionEvaluator.formatResult(fullExpr)
        // 清空表达式，准备下一轮计算
        this.expression = ''
        this.showExpression = false
        this.waitingForSecondOperand = true
      } catch (error) {
        this.showError()
      }
    } else if (this.operator && !this.waitingForSecondOperand) {
      // 兼容旧的两操作数模式
      const result = this.performComplexCalculation()
      if (this.hasError) {
        return
      }
      this.displayValue = ComplexCalculator.format(result)
      this.firstOperand = { real: 0, imag: 0 }
      this.operator = ''
      this.waitingForSecondOperand = true
    }
  }

  // 清除按钮点击处理
  handleClear(): void {
    this.displayValue = '0'
    this.firstOperand = { real: 0, imag: 0 }
    this.operator = ''
    this.waitingForSecondOperand = false
    this.hasError = false
    this.expression = ''
    this.showExpression = false
  }

  // 小数点按钮点击处理
  handleDecimal(): void {
    if (this.hasError) {
      this.handleClear()
    }

    if (this.waitingForSecondOperand) {
      this.displayValue = '0.'
      this.waitingForSecondOperand = false
    } else if (this.displayValue.indexOf('.') === -1) {
      // 限制数字长度
      if (this.displayValue.length < 15) {
        this.displayValue += '.'
      }
    }
  }

  // 百分比按钮点击处理
  handlePercentage(): void {
    if (this.hasError) {
      return
    }

    const currentValue = ComplexCalculator.parse(this.displayValue)
    const result: Complex = {
      real: currentValue.real / 100,
      imag: currentValue.imag / 100
    }
    this.displayValue = ComplexCalculator.format(result)
  }

  // 正负号按钮点击处理
  handleToggleSign(): void {
    if (this.hasError) {
      return
    }

    const currentValue = ComplexCalculator.parse(this.displayValue)
    const result: Complex = {
      real: -currentValue.real,
      imag: -currentValue.imag
    }
    this.displayValue = ComplexCalculator.format(result)
  }

  // 虚数单位 'j' 按钮点击处理
  handleImaginaryUnit(): void {
    if (this.hasError) {
      this.handleClear()
    }

    // 如果等待输入第二个操作数，直接显示虚数单位
    if (this.waitingForSecondOperand) {
      this.displayValue = 'j'
      this.waitingForSecondOperand = false
      return
    }

    // 如果当前是纯实数且没有虚数单位，添加虚数单位
    if (!this.displayValue.includes('j')) {
      const cleanValue = this.displayValue.trim()
      // 移除前导的正号
      const normalizedValue = cleanValue.startsWith('+') ? cleanValue.substring(1) : cleanValue

      // 如果当前值是 "0" 或空，直接显示 "j"
      if (normalizedValue === '0' || normalizedValue === '') {
        this.displayValue = 'j'
      } else {
        // 否则在当前值后添加 "j"（自动处理符号）
        this.displayValue = normalizedValue + 'j'
      }
    } else {
      // 如果已经有虚数单位，解析并规范化显示
      const currentComplex = ComplexCalculator.parse(this.displayValue)
      this.displayValue = ComplexCalculator.format(currentComplex)
    }
  }

  build() {
    Column() {
      // 显示区域
      Column() {
        // 表达式显示（可选）
        if (this.showExpression && this.expression !== '') {
          Text(this.expression)
            .fontSize($r('app.float.expression_font_size', 16))
            .fontColor($r('app.color.expression_text', '#999999'))
            .textAlign(TextAlign.End)
            .maxLines(1)
            .width('100%')
            .margin({ bottom: 5 })
        }

        // 结果显示
        Text(this.displayValue)
          .fontSize($r('app.float.display_font_size'))
          .fontColor($r('app.color.display_text'))
          .textAlign(TextAlign.End)
          .maxLines(1)
          .width('100%')
      }
      .height('20%')
      .width('100%')
      .padding({
        left: 20,
        right: 20,
        top: 10,
        bottom: 10
      })
      .backgroundColor($r('app.color.display_background'))
      .justifyContent(FlexAlign.End)

      // 按钮区域
      Column() {
        // 第一行：功能按钮
        Row() {
          this.CalculatorButton('C', 'function', () => this.handleClear())
          this.CalculatorButton('±', 'function', () => this.handleToggleSign())
          this.CalculatorButton('%', 'function', () => this.handlePercentage())
          this.CalculatorButton('÷', 'operator', () => this.handleOperator('÷'))
        }
        .layoutWeight(1)

        // 第二行：数字7-9和乘号
        Row() {
          this.CalculatorButton('7', 'number', () => this.handleNumberInput('7'))
          this.CalculatorButton('8', 'number', () => this.handleNumberInput('8'))
          this.CalculatorButton('9', 'number', () => this.handleNumberInput('9'))
          this.CalculatorButton('×', 'operator', () => this.handleOperator('×'))
        }
        .layoutWeight(1)

        // 第三行：数字4-6和减号
        Row() {
          this.CalculatorButton('4', 'number', () => this.handleNumberInput('4'))
          this.CalculatorButton('5', 'number', () => this.handleNumberInput('5'))
          this.CalculatorButton('6', 'number', () => this.handleNumberInput('6'))
          this.CalculatorButton('-', 'operator', () => this.handleOperator('-'))
        }
        .layoutWeight(1)

        // 第四行：数字1-3和加号
        Row() {
          this.CalculatorButton('1', 'number', () => this.handleNumberInput('1'))
          this.CalculatorButton('2', 'number', () => this.handleNumberInput('2'))
          this.CalculatorButton('3', 'number', () => this.handleNumberInput('3'))
          this.CalculatorButton('+', 'operator', () => this.handleOperator('+'))
        }
        .layoutWeight(1)

        // 第五行：数字0、小数点和等号
        Row() {
          this.CalculatorButton('0', 'number', () => this.handleNumberInput('0'))
          this.CalculatorButton('.', 'number', () => this.handleDecimal())
          this.CalculatorButton('j', 'operator', () => this.handleImaginaryUnit())
          this.CalculatorButton('=', 'operator', () => this.handleEquals())
        }
        .layoutWeight(1)
      }
      .height('80%')
      .width('100%')
      .padding(10)
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.calculator_background'))
  }

  @Builder
  CalculatorButton(label: string, type: string, onClick: () => void): void {
    Button(label) {
      Text(label)
        .fontSize($r('app.float.button_font_size'))
        .fontColor(this.getButtonTextColor(type))
        .fontWeight(FontWeight.Bold)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.getButtonBackgroundColor(type))
    .borderRadius($r('app.float.button_corner_radius'))
    .layoutWeight(1)
    .margin(5)
    .onClick(onClick)
  }

  // 获取按钮背景色
  getButtonBackgroundColor(type: string): ResourceColor {
    switch (type) {
      case 'number':
        return $r('app.color.number_button')
      case 'operator':
        return $r('app.color.operator_button')
      case 'function':
        return $r('app.color.function_button')
      default:
        return $r('app.color.number_button')
    }
  }

  // 获取按钮文字颜色
  getButtonTextColor(type: string): ResourceColor {
    switch (type) {
      case 'number':
        return $r('app.color.number_button_text')
      case 'operator':
        return $r('app.color.operator_button_text')
      case 'function':
        return $r('app.color.function_button_text')
      default:
        return $r('app.color.number_button_text')
    }
  }
}