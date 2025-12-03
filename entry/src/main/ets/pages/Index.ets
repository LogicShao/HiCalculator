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
  @State expression: string = ''
  @State showExpression: boolean = false

  // 数字按钮点击处理
  handleNumberInput(number: string): void {
    if (this.hasError) {
      this.handleClear()
    }

    if (this.waitingForSecondOperand || this.expression !== '') {
      this.displayValue = number
      this.waitingForSecondOperand = false
    } else {
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

    if (this.displayValue) {
      this.expression += this.displayValue + ' ' + nextOperator + ' '
    }

    this.waitingForSecondOperand = true
    this.operator = nextOperator
    this.showExpression = true
  }

  // 显示错误
  showError(): void {
    this.displayValue = 'Error!'
    this.hasError = true
  }

  // 等号按钮点击处理 - 统一使用 ExpressionEvaluator
  handleEquals(): void {
    if (this.hasError) {
      return
    }

    const fullExpr = this.expression + this.displayValue

    try {
      this.displayValue = ExpressionEvaluator.formatResult(fullExpr)
      this.expression = ''
      this.showExpression = false
      this.waitingForSecondOperand = true
      this.firstOperand = ComplexCalculator.parse(this.displayValue)
    } catch (error) {
      this.showError()
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

    if (this.waitingForSecondOperand) {
      this.displayValue = 'j'
      this.waitingForSecondOperand = false
      return
    }

    if (!this.displayValue.includes('j')) {
      const cleanValue = this.displayValue.trim()
      const normalizedValue = cleanValue.startsWith('+') ? cleanValue.substring(1) : cleanValue

      if (normalizedValue === '0' || normalizedValue === '') {
        this.displayValue = 'j'
      } else {
        this.displayValue = normalizedValue + 'j'
      }
    } else {
      const currentComplex = ComplexCalculator.parse(this.displayValue)
      this.displayValue = ComplexCalculator.format(currentComplex)
    }
  }

  build() {
    Column() {
      Column() {
        if (this.showExpression && this.expression !== '') {
          Text(this.expression)
            .fontSize($r('app.float.expression_font_size', 16))
            .fontColor($r('app.color.expression_text', '#999999'))
            .textAlign(TextAlign.End)
            .maxLines(1)
            .width('100%')
            .margin({ bottom: 5 })
        }

        Text(this.displayValue)
          .fontSize($r('app.float.display_font_size'))
          .fontColor($r('app.color.display_text'))
          .textAlign(TextAlign.End)
          .maxLines(1)
          .width('100%')
      }
      .height('20%')
      .width('100%')
      .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      .backgroundColor($r('app.color.display_background'))
      .justifyContent(FlexAlign.End)

      Column() {
        Row() {
          this.CalculatorButton('C', 'function', () => this.handleClear())
          this.CalculatorButton('±', 'function', () => this.handleToggleSign())
          this.CalculatorButton('%', 'function', () => this.handlePercentage())
          this.CalculatorButton('÷', 'operator', () => this.handleOperator('÷'))
        }
        .layoutWeight(1)

        Row() {
          this.CalculatorButton('7', 'number', () => this.handleNumberInput('7'))
          this.CalculatorButton('8', 'number', () => this.handleNumberInput('8'))
          this.CalculatorButton('9', 'number', () => this.handleNumberInput('9'))
          this.CalculatorButton('×', 'operator', () => this.handleOperator('×'))
        }
        .layoutWeight(1)

        Row() {
          this.CalculatorButton('4', 'number', () => this.handleNumberInput('4'))
          this.CalculatorButton('5', 'number', () => this.handleNumberInput('5'))
          this.CalculatorButton('6', 'number', () => this.handleNumberInput('6'))
          this.CalculatorButton('-', 'operator', () => this.handleOperator('-'))
        }
        .layoutWeight(1)

        Row() {
          this.CalculatorButton('1', 'number', () => this.handleNumberInput('1'))
          this.CalculatorButton('2', 'number', () => this.handleNumberInput('2'))
          this.CalculatorButton('3', 'number', () => this.handleNumberInput('3'))
          this.CalculatorButton('+', 'operator', () => this.handleOperator('+'))
        }
        .layoutWeight(1)

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
      .padding({ top: 0, bottom: 0, left: 10, right: 10 })
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
    .margin(2)
    .onClick(onClick)
  }

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
