/*
 *  Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */

package org.ballerinalang.stdlib.streams;

import org.ballerinalang.model.values.BInteger;
import org.ballerinalang.model.values.BMap;
import org.ballerinalang.model.values.BValue;
import org.ballerinalang.test.util.BCompileUtil;
import org.ballerinalang.test.util.BRunUtil;
import org.ballerinalang.test.util.CompileResult;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

/**
 * This contains methods to test external function call in select clause (with aggregation and without group by)
 * in Ballerina Streaming V2.
 *
 * @since 0.990.0
 */
public class BallerinaStreamsV2AggregatorWithoutGroupByTest {

    private CompileResult result;

    @BeforeClass
    public void setup() {
        result = BCompileUtil.compile("test-src/streamingv2-aggregate-without-groupby-test.bal");
    }

    @Test(description = "Test streaming query without group by clause")
    public void testSelectQuery() {
        BValue[] outputTeacherEvents = BRunUtil.invoke(result, "startAggregationWithoutGroupByQuery");
        Assert.assertNotNull(outputTeacherEvents);
        Assert.assertEquals(outputTeacherEvents.length, 4, "Expected events are not received");

        BMap<String, BValue> teacher0 = (BMap<String, BValue>) outputTeacherEvents[0];
        BMap<String, BValue> teacher1 = (BMap<String, BValue>) outputTeacherEvents[1];
        BMap<String, BValue> teacher2 = (BMap<String, BValue>) outputTeacherEvents[2];
        BMap<String, BValue> teacher3 = (BMap<String, BValue>) outputTeacherEvents[3];

        Assert.assertEquals(teacher0.get("name").stringValue(), "Mohan");
        Assert.assertEquals(((BInteger) teacher0.get("sumAge")).intValue(), 30);
        Assert.assertEquals(((BInteger) teacher0.get("count")).intValue(), 1);

        Assert.assertEquals(teacher1.get("name").stringValue(), "Raja");
        Assert.assertEquals(((BInteger) teacher1.get("sumAge")).intValue(), 75);
        Assert.assertEquals(((BInteger) teacher1.get("count")).intValue(), 2);

        Assert.assertEquals(teacher2.get("name").stringValue(), "Raja");
        Assert.assertEquals(((BInteger) teacher2.get("sumAge")).intValue(), 120);
        Assert.assertEquals(((BInteger) teacher2.get("count")).intValue(), 3);

        Assert.assertEquals(teacher3.get("name").stringValue(), "Mohan");
        Assert.assertEquals(((BInteger) teacher3.get("sumAge")).intValue(), 150);
        Assert.assertEquals(((BInteger) teacher3.get("count")).intValue(), 4);
    }
}
