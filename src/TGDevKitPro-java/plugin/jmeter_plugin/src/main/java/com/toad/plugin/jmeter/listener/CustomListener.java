package com.toad.plugin.jmeter.listener;

import org.apache.jmeter.samplers.SampleEvent;
import org.apache.jmeter.samplers.SampleListener;
import org.apache.jmeter.samplers.SampleResult;
import org.apache.jmeter.visualizers.gui.AbstractVisualizer;

import javax.swing.*;
import java.awt.*;

public class CustomListener extends AbstractVisualizer implements SampleListener {

    private JTextArea textArea;

    @Override
    public String getLabelResource() {
        return "Custom Listener";
    }

    @Override
    public String getStaticLabel() {
        return "Custom Listener";
    }

    @Override
    public void add(SampleResult sample) {
        // 处理采样结果
        if (textArea != null) {
            textArea.append("Sample received: " + sample.getSampleLabel() + "\n");
        }
    }

    @Override
    public void sampleOccurred(SampleEvent event) {
        add(event.getResult());
    }

    @Override
    public void sampleStarted(SampleEvent sampleEvent) {

    }

    @Override
    public void sampleStopped(SampleEvent sampleEvent) {

    }

    @Override
    public void clearData() {
        if (textArea != null) {
            textArea.setText("");
        }
    }

    public JComponent getPreviewPanel() {
        return createPanel();
    }

    protected Component createTitlePanel() {
        return new JLabel(getStaticLabel(), JLabel.CENTER);
    }

    public void init() {
        this.setLayout(new BorderLayout());
        this.add(createTitlePanel(), BorderLayout.NORTH);
        this.add(createPanel(), BorderLayout.CENTER);
    }

    private JComponent createPanel() {
        if (textArea == null) {
            textArea = new JTextArea(10, 50);
            textArea.setEditable(false);
        }
        return new JScrollPane(textArea);
    }
}