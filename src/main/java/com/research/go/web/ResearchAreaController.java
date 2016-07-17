package com.research.go.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/research-area")
public class ResearchAreaController {

    private static final Logger LOG = LoggerFactory.getLogger(ResearchAreaController.class);

    @RequestMapping(value = "", method = RequestMethod.GET)
    public Object showAll() throws Exception {

        return "{\"test\":\"test\"}";
    }
}
