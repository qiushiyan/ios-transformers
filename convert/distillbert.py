# adapted from https://coremltools.readme.io/docs/convert-tensorflow-2-bert-transformer-models#convert-the-distilbert-transformer-model
import coremltools as ct
import numpy as np
import tensorflow as tf
from transformers import DistilBertTokenizer, TFDistilBertForMaskedLM

tokenizer = DistilBertTokenizer.from_pretrained("distilbert-base-uncased-distilled-squad")
distilbert_model = TFDistilBertForMaskedLM.from_pretrained(
    "distilbert-base-uncased-distilled-squad"
)

max_seq_length = 20
input_shape = (1, max_seq_length)  # (batch_size, maximum_sequence_length)

input_layer = tf.keras.layers.Input(shape=input_shape[1:], dtype=tf.int32, name="input")

prediction_model = distilbert_model(input_layer)
tf_model = tf.keras.models.Model(inputs=input_layer, outputs=prediction_model)

mlmodel = ct.convert(tf_model)

mlmodel.save("distilbert.mlmodel")
