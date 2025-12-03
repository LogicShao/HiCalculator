import localUnitTest from './LocalUnit.test';
import expressionEvaluatorTest from './ExpressionEvaluator.test';
import complexDisplayTest from './ComplexDisplay.test';

export default function testsuite() {
  localUnitTest();
  expressionEvaluatorTest();
  complexDisplayTest();
}