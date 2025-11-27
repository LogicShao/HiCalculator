@Entry
@Component
struct Index {
  @State displayValue: string = '0'
  @State firstOperand: number = 0
  @State operator: string = ''
  @State waitingForSecondOperand: boolean = false
  // 数字按钮点击处理
  handleNumberInput(number: string): void {
    if (this.waitingForSecondOperand) {
      this.displayValue = number
      this.waitingForSecondOperand = false
    } else {
      this.displayValue = this.displayValue === '0' ? number : this.displayValue + number
    }
  }
  // 运算符按钮点击处理
  handleOperator(nextOperator: string): void {
    const inputValue = parseFloat(this.displayValue)

    if (this.firstOperand === 0) {
      this.firstOperand = inputValue
    } else if (this.operator) {
      const result = this.performCalculation()
      this.displayValue = `${result}`
      this.firstOperand = result
    }

    this.waitingForSecondOperand = true
    this.operator = nextOperator
  }

  // 执行计算
  performCalculation(): number {
    const inputValue = parseFloat(this.displayValue)

    switch (this.operator) {
      case '+':
        return this.firstOperand + inputValue
      case '-':
        return this.firstOperand - inputValue
      case '×':
        return this.firstOperand * inputValue
      case '÷':
        return this.firstOperand / inputValue
      default:
        return inputValue
    }
  }
  // 等号按钮点击处理
  handleEquals(): void {
    if (this.operator && !this.waitingForSecondOperand) {
      const result = this.performCalculation()
      this.displayValue = `${result}`
      this.firstOperand = 0
      this.operator = ''
      this.waitingForSecondOperand = true
    }
  }
  // 清除按钮点击处理
  handleClear(): void {
    this.displayValue = '0'
    this.firstOperand = 0
    this.operator = ''
    this.waitingForSecondOperand = false
  }
  // 小数点按钮点击处理
  handleDecimal(): void {
    if (this.waitingForSecondOperand) {
      this.displayValue = '0.'
      this.waitingForSecondOperand = false
    } else if (this.displayValue.indexOf('.') === -1) {
      this.displayValue += '.'
    }
  }
  // 百分比按钮点击处理
  handlePercentage(): void {
    const currentValue = parseFloat(this.displayValue)
    this.displayValue = `${currentValue / 100}`
  }
  // 正负号按钮点击处理
  handleToggleSign(): void {
    const currentValue = parseFloat(this.displayValue)
    this.displayValue = `${-currentValue}`
  }

  build() {
    Column() {
      // 显示区域
      Row() {
        Text(this.displayValue)
          .fontSize($r('app.float.display_font_size'))
          .fontColor($r('app.color.display_text'))
          .textAlign(TextAlign.End)
          .maxLines(1)
          .layoutWeight(1)
      }
      .height('20%')
      .width('100%')
      .padding({ left: 20, right: 20 })
      .backgroundColor($r('app.color.display_background'))

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